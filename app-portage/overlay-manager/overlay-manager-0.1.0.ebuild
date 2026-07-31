# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="TUI application for managing Gentoo Portage overlays"
HOMEPAGE="https://github.com/Darllowin/overlay-manager"
SRC_URI="https://github.com/Darllowin/Overlay-manager/archive/refs/heads/master.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-lang/rust-1.95"
RDEPEND="${DEPEND}
	sys-apps/portage"

S="${WORKDIR}/Overlay-manager-master"

src_compile() {
	cargo build --release
}

src_install() {
	dobin target/release/overlay-manager
}
