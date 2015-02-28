# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-r3 python-single-r1

DESCRIPTION="The Multiple Git Repository Tool from the Android Open Source Project"
HOMEPAGE="http://code.google.com/p/git-repo/"
EGIT_REPO_URI="https://gerrit.googlesource.com/git-repo"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	${PYTHON_DEPS}
	dev-vcs/git
"

src_prepare() {
	python_fix_shebang "${PN}"
}

src_install() {
	dobin "${PN}"
}
