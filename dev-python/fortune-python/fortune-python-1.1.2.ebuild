EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

DESCRIPTION="A Fortune clone in Python"
HOMEPAGE="https://codeberg.org/jamesansley/fortune"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
