EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit cmake git-r3 python-any-r1 xdg

DESCRIPTION="Telegram Desktop fork with Material Design and additional improvements"
HOMEPAGE="https://github.com/KUKURUZKA165/materialgram"

EGIT_REPO_URI="https://github.com/kukuruzka165/materialgram.git"
EGIT_COMMIT="v${PV}"

EGIT_SUBMODULES=(
    'cmake'
    'cmake/external/glib/cppgir'
    'cmake/external/glib/cppgir/expected-lite'

    'Telegram/lib_rpl'
    'Telegram/lib_crl'
    'Telegram/lib_base'
    'Telegram/lib_ui'
    'Telegram/lib_tl'
    'Telegram/lib_spellcheck'
    'Telegram/lib_storage'
    'Telegram/lib_lottie'
    'Telegram/lib_qr'
    'Telegram/lib_translate'
    'Telegram/lib_webrtc'
    'Telegram/lib_webview'
    'Telegram/codegen'

    'Telegram/ThirdParty/GSL'
    'Telegram/ThirdParty/xxHash'
    'Telegram/ThirdParty/rlottie'
    'Telegram/ThirdParty/lz4'
    'Telegram/ThirdParty/expected'
    'Telegram/ThirdParty/QR'
    'Telegram/ThirdParty/hunspell'
    'Telegram/ThirdParty/range-v3'
    'Telegram/ThirdParty/fcitx5-qt'
    'Telegram/ThirdParty/kcoreaddons'
    'Telegram/ThirdParty/cld3'
    'Telegram/ThirdParty/cmark-gfm'
    'Telegram/ThirdParty/MicroTeX'
    'Telegram/ThirdParty/kimageformats'
    'Telegram/ThirdParty/hime'
    'Telegram/ThirdParty/nimf'
    'Telegram/ThirdParty/tgcalls'
    'Telegram/ThirdParty/libprisma'
    'Telegram/ThirdParty/TooManyCooks'
    'Telegram/ThirdParty/xdg-desktop-portal'
)

LICENSE="GPL-3-with-openssl-exception BSD LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="dbus screencast wayland webkit X"

REQUIRED_USE="|| ( wayland X )"

CDEPEND="
    app-arch/lz4:=
    dev-cpp/abseil-cpp:=
    dev-cpp/ada:=
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
    dev-qt/qtshadertools:6
    dev-qt/qtsvg:6
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
    virtual/minizip
    virtual/pkgconfig

    dbus? (
        dev-qt/qtbase:6[dbus]
    )

    screencast? (
        media-video/pipewire:=
    )

    wayland? (
        dev-util/wayland-scanner
    )

    webkit? (
        net-libs/webkit-gtk:4.1
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
"

BDEPEND="
    ${PYTHON_DEPS}
    dev-build/cmake
    dev-qt/qttools:6
    dev-util/desktop-file-utils
    dev-util/gdbus-codegen
"

src_configure() {
    export XDG_DATA_DIRS="${ESYSROOT}/usr/share"

    filter-flags -fno-delete-null-pointer-checks
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

        -DCMAKE_REQUIRE_FIND_PACKAGE_Qt6DBus="$(usex dbus)"
        -DCMAKE_REQUIRE_FIND_PACKAGE_Qt6Quick="${use_webkit_wayland}"
        -DCMAKE_REQUIRE_FIND_PACKAGE_Qt6QuickWidgets="${use_webkit_wayland}"
        -DCMAKE_REQUIRE_FIND_PACKAGE_Qt6WaylandCompositor="${use_webkit_wayland}"

        -DTDESKTOP_API_ID="${MY_TDESKTOP_API_ID:-611335}"
        -DTDESKTOP_API_HASH="${MY_TDESKTOP_API_HASH:-d524b414d21f4d37f08684c1df41ac9c}"
    )

    cmake_src_configure
}

src_compile() {
    local targets

    targets=$(
        "${CMAKE_BINARY}" --build "${BUILD_DIR}" -t help 2>/dev/null |
            sed -n '/^[^/]*_cppgir:/s/:.*//p'
    )

    if [[ -n ${targets} ]]; then
        cmake_build ${targets}
    fi

    cmake_build
}

src_install() {
    cmake_src_install

    if [[ -x ${ED}/usr/bin/Telegram ]]; then
        mv "${ED}/usr/bin/Telegram" \
            "${ED}/usr/bin/materialgram" || die
    fi

    if [[ ! -f ${ED}/usr/share/applications/io.github.kukuruzka165.materialgram.desktop ]] &&
        [[ -f ${ED}/usr/share/applications/org.telegram.desktop.desktop ]]; then
        mv "${ED}/usr/share/applications/org.telegram.desktop.desktop" \
            "${ED}/usr/share/applications/materialgram.desktop" || die

        sed -i \
            -e 's/^Name=Telegram$/Name=Materialgram/' \
            -e 's|^Exec=telegram-desktop|Exec=materialgram|' \
            "${ED}/usr/share/applications/materialgram.desktop" || die
    fi
}
