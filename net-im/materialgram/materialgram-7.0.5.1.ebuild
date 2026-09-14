```ebuild
# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit cmake optfeature python-any-r1 xdg git-r3

DESCRIPTION="Telegram Desktop fork with Material Design and additional improvements"
HOMEPAGE="
	https://github.com/kukuruzka165/materialgram
	https://kukuruzka165.github.io/materialgram/
"

EGIT_REPO_URI="https://github.com/kukuruzka165/materialgram.git"
EGIT_COMMIT="v${PV}"

# Do not fetch git submodules automatically yet.
# Materialgram contains a large number of Telegram-specific submodules.
EGIT_SUBMODULES=()

LICENSE="GPL-3-with-openssl-exception BSD LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="dbus enchant fonts screencast wayland webkit X"

REQUIRED_USE="
	|| ( wayland X )
"

CDEPEND="
	app-arch/lz4:=
	dev-cpp/abseil-cpp:=
	dev-cpp/ada:=
	dev-cpp/cld3:=
	dev-cpp/cppgir:=
	dev-cpp/expected
	dev-cpp/expected-lite
	dev-cpp/ms-gsl
	dev-cpp/range-v3
	dev-cpp/toomanycooks
	dev-libs/glib:2
	dev-libs/libfido2:=
	dev-libs/openssl:=
	dev-libs/qr-code-generator:=
	dev-libs/xxhash
	dev-qt/qtbase:6
	dev-qt/qtdeclarative:6
	dev-qt/qtimageformats:6
	dev-qt/qtsvg:6
	dev-qt/qtshadertools:6
	dev-qt/qtwayland:6
	kde-frameworks/kcoreaddons:6
	media-libs/libjpeg-turbo:=
	media-libs/openal
	media-libs/opus
	media-libs/rnnoise:=
	media-libs/tg_owt:=
	media-video/ffmpeg:=
	net-libs/tdlib:=[tde2e]
	sys-apps/hwloc:=
	virtual/minizip:=
	virtual/pkgconfig

	dbus? (
		dev-qt/qtbase:6[dbus]
	)

	enchant? (
		app-text/enchant:=
	)

	!enchant? (
		app-text/hunspell:=
	)

	screencast? (
		media-video/pipewire:=
	)

	wayland? (
		dev-qt/qtwayland:6
		dev-util/wayland-scanner
	)

	X? (
		x11-libs/libxcb
		x11-libs/xcb-util-keysyms
	)
"

DEPEND="
	${CDEPEND}
	${PYTHON_DEPS}
"

RDEPEND="
	${CDEPEND}

	webkit? (
		net-libs/webkit-gtk:4.1
	)
"

BDEPEND="
	${PYTHON_DEPS}
	dev-build/cmake
	dev-util/desktop-file-utils
	dev-util/gdbus-codegen
"

src_prepare() {
	# Materialgram is a Telegram Desktop fork and currently relies on
	# several git submodules. Do not remove or replace bundled components
	# until the actual build requirements have been examined.

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DQT_VERSION_MAJOR=6

		-DESKTOP_APP_USE_PACKAGED=ON
		-DESKTOP_APP_DISABLE_AUTOUPDATE=ON
		-DESKTOP_APP_DISABLE_CRASH_REPORTS=ON

		-DESKTOP_APP_USE_PACKAGED_FONTS=$(usex fonts ON OFF)

		-DESKTOP_APP_USE_ENCHANT=$(usex enchant ON OFF)

		-DTDESKTOP_API_ID="${MY_TDESKTOP_API_ID:-611335}"
		-DTDESKTOP_API_HASH="${MY_TDESKTOP_API_HASH:-d524b414d21f4d37f08684c1df41ac9c}"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if [[ -x ${ED}/usr/bin/Telegram ]]; then
		mv "${ED}/usr/bin/Telegram" "${ED}/usr/bin/materialgram" || die
	fi

	if [[ -f ${ED}/usr/share/applications/org.telegram.desktop.desktop ]]; then
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

	optfeature_header

	optfeature \
		"image format support" \
		kde-frameworks/kimageformats:6
}
```
