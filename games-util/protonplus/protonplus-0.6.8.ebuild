EAPI=8

inherit gnome2-utils meson

DESCRIPTION="A modern compatibility tools manager for Linux"
HOMEPAGE="https://github.com/Vysp3r/ProtonPlus"

SRC_URI="https://github.com/Vysp3r/ProtonPlus/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ProtonPlus-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    app-arch/libarchive
    dev-libs/appstream
    dev-libs/glib:2
    dev-libs/json-glib
    dev-libs/libgee
    gui-libs/gtk:4
    gui-libs/libadwaita:=
    media-libs/libsdl3:=
    net-libs/libsoup:3.0
    x11-libs/cairo
    x11-libs/libnotify
"

DEPEND="${RDEPEND}"

BDEPEND="
    dev-build/meson
    dev-lang/vala
    dev-util/desktop-file-utils
    sys-devel/gettext
    virtual/pkgconfig
"

pkg_postinst() {
    gnome2_schemas_update
    xdg_pkg_postinst
}

pkg_postrm() {
    gnome2_schemas_update
    xdg_pkg_postrm
}
