# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fuse-python/fuse-python-0.2.1-r1.ebuild,v 1.1 2014/04/11 22:28:44 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} pypy )

inherit distutils-r1

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Python FUSE bindings"
HOMEPAGE="http://fuse.sourceforge.net/wiki/index.php/FusePython"

SRC_URI="mirror://sourceforge/fuse/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="examples"

RDEPEND=">=sys-fs/fuse-2.0"
DEPEND="${RDEPEND}"

python_prepare() {
	if [[ ${EPYTHON} == python3.* ]]; then
		find -type f -name '*.py' -exec 2to3 -nw --no-diffs '{}' + || die
		epatch "${FILESDIR}/fuse-python-python3-support.patch"
	fi
}

python_install_all() {
	use examples && local EXAMPLES=( example/. )
	distutils-r1_python_install_all
}
