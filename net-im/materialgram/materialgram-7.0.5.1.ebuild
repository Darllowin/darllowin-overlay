# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit xdg cmake python-any-r1 optfeature flag-o-matic git-r3

DESCRIPTION="Telegram Desktop fork with Material Design and other improvements"
HOMEPAGE="
	https://github.com/kukuruzka165/materialgram
	https://kukuruzka165.github.io/materialgram/
"

EGIT_REPO_URI="https://github.com/kukuruzka165/materialgram.git"
EGIT_COMMIT="v${PV}"
EGIT_SUBMODULES=( '*' )

LICENSE="BSD GPL-3-with-openssl-exception LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="dbus enchant +fonts screencast wayland webkit +X"

CDEPEND="
	!net-im/telegram-desktop
	!net-im/telegram-desktop-bin

	app-arch/lz4:=
	dev-cpp/abseil-cpp:=
	dev-cpp/ada:=
	dev-cpp/cld3:=
	dev-cpp/toomanycooks
	dev-libs/glib:2
	dev-libs/libfido2:=
	dev-libs/openssl:=
	dev-libs/qr-code-generator:=
	dev-libs/xxhash
	>=dev-qt/qtbase-6.11:6=[dbus?,gui,network,opengl,ssl,wayland?,widgets]
	>=dev-qt/qtimageformats-6.11:6
	>=dev-qt/qtsvg-6.11:6
	kde-frameworks/kcoreaddons:6
	media-libs/libjpeg-turbo:=
	media-libs/openal
	media-libs/rnnoise:=
	>=media-libs/tg_owt-0_pre20241202:=[screencast=,X=]
	>=media-video/ffmpeg-6:=[opus,vpx,x264]
	net-libs/tdlib:=[tde2e]
	sys-apps/hwloc:=
	virtual/minizip:=

	!enchant? (
		>=app-text/hunspell-1.7:=
	)
	enchant? (
		app-text/enchant:=
	)

	webkit? (
		wayland? (
			>=dev-qt/qtdeclarative-6.11:6
			>=dev-qt/qtwayland-6.11:6[compositor(+),qml]
		)
	)
"

RDEPEND="
	${CDEPEND}

	webkit? (
		|| (
			net-libs/webkit-gtk:4.1
			net-libs/webkit-gtk:6
		)
	)
"

DEPEND="
	${CDEPEND}

	>=dev-cpp/cppgir-2.0_p20240315
	dev-cpp/expected
	dev-cpp/expected-lite
	>=dev-cpp/ms-gsl-4.1.0
	dev-cpp/range-v3
	>=dev-libs/protobuf-21.12
"

BDEPEND="
	${PYTHON_DEPS}

	>=dev-build/cmake-3.16
	>=dev-cpp/cppgir-2.0_p20260226
	dev-qt/qtshadertools
	>=dev-util/gdbus-codegen-2.80.5-r1
	virtual/pkgconfig

	webkit? (
		wayland? (
			dev-util/wayland-scanner
		)
	)
"

PATCHES=(
	"${FILESDIR}"/tdesktop-5.7.2-cstring.patch
	"${FILESDIR}"/tdesktop-5.8.3-cstdint.patch
	"${FILESDIR}"/tdesktop-5.14.3-system-cppgir.patch
)

src_prepare() {
	# Make missing system libraries fail immediately instead of silently
	# falling back to bundled copies.
	find -type f \( -name 'CMakeLists.txt' -o -name '*.cmake' \) \
		\! -path './cmake/external/qt/package.cmake' \
		-print0 | xargs -0 sed -i \
		-e '/pkg_check_modules(/s/[^ ]*)/REQUIRED &/' \
		-e '/find_package(/s/)/ REQUIRED)/' \
		-e '/find_library(/s/)/ REQUIRED)/' \
		-e '/find_path(/s/)/ REQUIRED)/' || die

	# These components have proper Gentoo/system packages.
	sed -e '/find_package(lz4 /d' \
		-i cmake/external/lz4/CMakeLists.txt || die

	sed -e '/find_package(xxHash /d' \
		-i cmake/external/xxhash/CMakeLists.txt || die

	sed -e '/find_package(minizip /d' \
		-i cmake/external/minizip/CMakeLists.txt || die

	# Keep Telegram-specific/private libraries bundled.
	local keep=(
		rlottie
		cmark-gfm
		libprisma
		tgcalls
		xdg-desktop-portal
		MicroTeX
	)

	for x in Telegram/ThirdParty/*; do
		has "${x##*/}" "${keep[@]}" || rm -r "${x}" || die
	done

	# Bundled codecs are only needed for upstream's bundled FFmpeg.
	: > cmake/external/openh264/CMakeLists.txt || die
	: > cmake/external/opus/CMakeLists.txt || die
	: > cmake/external/vpx/CMakeLists.txt || die

	# Do not use bundled libdispatch.
	: > cmake/external/dispatch/CMakeLists.txt || die

	# QtDBus is controlled by the USE flag.
	if ! use dbus; then
		sed -e '/find_package(Qt[^ ]* OPTIONAL_COMPONENTS/s/DBus *//' \
			-i cmake/external/qt/package.cmake || die
	fi

	# Qt Wayland compositor is only required for webkit + wayland.
	if ! use webkit || ! use wayland; then
		sed -e 's/QT_CONFIG(wayland_compositor_quick)/0/' \
			-i Telegram/lib_webview/webview/platform/linux/webview_linux_compositor.h || die
	fi

	# CMake 4 cleanup.
	rm -f \
		Telegram/ThirdParty/rlottie/CMakeLists.txt \
		Telegram/ThirdParty/cmark-gfm/CMakeLists.txt \
		Telegram/ThirdParty/hunspell/CMakeLists.txt \
		Telegram/ThirdParty/range-v3/CMakeLists.txt || die

	# Prevent bundled cppgir example/test projects from being considered.
	rm -rf Telegram/ThirdParty/cmark-gfm/tests || die

	cmake_src_prepare
}

src_configure() {
	# cppgir must see the actual system data directories.
	export XDG_DATA_DIRS="${ESYSROOT}/usr/share"

	filter-flags -fno-delete-null-pointer-checks

	# Must match tg_owt's build ABI.
	append-cppflags -DNDEBUG

	local no_webkit_wayland
	local use_webkit_wayland

	if use webkit && use wayland; then
		no_webkit_wayland=no
		use_webkit_wayland=yes
	else
		no_webkit_wayland=yes
		use_webkit_wayland=no
	fi

	local mycmakeargs=(
		-DQT_VERSION_MAJOR=6

		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=OFF

		-DCMAKE_DISABLE_FIND_PACKAGE_Qt6Quick="${no_webkit_wayland}"
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt6QuickWidgets="${no_webkit_wayland}"
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt6WaylandCompositor="${no_webkit_wayland}"

		-DCMAKE_REQUIRE_FIND_PACKAGE_Qt6DBus=$(usex dbus)
		-DCMAKE_REQUIRE_FIND_PACKAGE_Qt6Quick="${use_webkit_wayland}"
		-DCMAKE_REQUIRE_FIND_PACKAGE_Qt6QuickWidgets="${use_webkit_wayland}"
		-DCMAKE_REQUIRE_FIND_PACKAGE_Qt6WaylandCompositor="${use_webkit_wayland}"

		-DESKTOP_APP_USE_PACKAGED=ON
		-DESKTOP_APP_DISABLE_AUTOUPDATE=ON
		-DESKTOP_APP_DISABLE_CRASH_REPORTS=ON
		-DESKTOP_APP_DISABLE_QT_PLUGINS=ON

		-DESKTOP_APP_USE_ENCHANT=$(usex enchant)
		-DESKTOP_APP_USE_PACKAGED_FONTS=$(usex !fonts)
	)

	# Portage environment can provide personal Telegram API credentials:
	#
	# /etc/portage/env/net-im/materialgram
	#
	# MY_TDESKTOP_API_ID="..."
	# MY_TDESKTOP_API_HASH="..."
	if [[ -n ${MY_TDESKTOP_API_ID} && -n ${MY_TDESKTOP_API_HASH} ]]; then
		einfo "Using custom Telegram API credentials"

		mycmakeargs+=(
			-DTDESKTOP_API_ID="${MY_TDESKTOP_API_ID}"
			-DTDESKTOP_API_HASH="${MY_TDESKTOP_API_HASH}"
		)
	else
		# Gentoo's established credentials used for packaged Telegram builds.
		mycmakeargs+=(
			-DTDESKTOP_API_ID="611335"
			-DTDESKTOP_API_HASH="d524b414d21f4d37f08684c1df41ac9c"
		)
	fi

	cmake_src_configure
}

src_compile() {
	# cppgir can modify generated headers during the build. Building its
	# targets first prevents Telegram from being relinked near install time.
	cmake_build $("${CMAKE_BINARY}" --build "${BUILD_DIR}" -t help |
		sed -n '/^[^/]*_cppgir:/s/:.*//p')

	cmake_build
	cmake_build
}

src_install() {
	cmake_src_install

	# Materialgram inherits Telegram Desktop's upstream executable name.
	if [[ -x ${ED}/usr/bin/Telegram ]]; then
		mv "${ED}/usr/bin/Telegram" "${ED}/usr/bin/materialgram" || die
	fi

	# The desktop file from the Telegram codebase uses the upstream name.
	if [[ -e ${ED}/usr/share/applications/org.telegram.desktop.desktop ]]; then
		mv \
			"${ED}/usr/share/applications/org.telegram.desktop.desktop" \
			"${ED}/usr/share/applications/materialgram.desktop" || die

		sed -i \
			-e 's/^Name=Telegram$/Name=Materialgram/' \
			-e 's/^Exec=telegram-desktop/Exec=materialgram/' \
			"${ED}/usr/share/applications/materialgram.desktop" || die
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	if ! use X && ! use screencast; then
		ewarn "Both 'X' and 'screencast' USE flags are disabled."
		ewarn "Screen sharing will not work."
	fi

	optfeature_header

	optfeature \
		"AVIF, HEIF and JPEG XL image support" \
		kde-frameworks/kimageformats:6[avif,heif,jpegxl]
}
