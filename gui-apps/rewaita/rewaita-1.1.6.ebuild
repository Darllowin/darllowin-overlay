EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit gnome2-utils meson python-any-r1

DESCRIPTION="GTK4 application for customizing Adwaita themes"
HOMEPAGE="https://github.com/SwordPuffin/Rewaita"

SRC_URI="https://github.com/SwordPuffin/Rewaita/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Rewaita-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    dev-libs/glib:2
    gui-libs/gtk:4
    gui-libs/gtksourceview:5
    dev-python/numpy
    dev-python/fortune-python
    gui-libs/libadwaita:=
    dev-libs/libportal:=
    dev-python/pygobject
"

DEPEND="${RDEPEND}"

BDEPEND="
    dev-build/meson
    dev-lang/vala
    dev-util/desktop-file-utils
    sys-devel/gettext
    virtual/pkgconfig
"

src_install() {
    meson_src_install
    python_fix_shebang "${ED}/usr/bin/rewaita"
}

pkg_postinst() {
    gnome2_schemas_update
}

pkg_postrm() {
    gnome2_schemas_update
}
