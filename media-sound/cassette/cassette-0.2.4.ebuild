# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala xdg

DESCRIPTION="GTK4/Adwaita application that allows you to use Yandex Music service"
HOMEPAGE="https://altlinux.space/rirusha/Cassette"
SRC_URI="https://altlinux.space/api/v1/repos/rirusha/Cassette/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0-or-later"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	dev-libs/libxml2:2
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	media-libs/gstreamer:1.0
	net-libs/libsoup:3.0[ssl]
	net-libs/webkit-gtk:6
	x11-libs/gdk-pixbuf:2
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	dev-util/blueprint-compiler
	sys-devel/gettext
	virtual/pkgconfig
"

# Forgejo archive unpacks to a plain "cassette/" dir
S="${WORKDIR}/cassette"

pkg_setup() {
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dis_devel=false
		-Dwith_webkit=true
	)
	meson_src_configure
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
	glib-compile-schemas "${EPREFIX}"/usr/share/glib-2.0/schemas
}

pkg_postrm() {
	xdg_pkg_postrm
	glib-compile-schemas "${EPREFIX}"/usr/share/glib-2.0/schemas
}