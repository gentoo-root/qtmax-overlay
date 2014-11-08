# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPONAME="scratch/afiestas/pam-kwallet.git"
inherit kde4-base

DESCRIPTION="PAM module for kwallet"
HOMEPAGE="http://quickgit.kde.org/?p=scratch/afiestas/pam-kwallet.git"

LICENSE="LGPL"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="
	virtual/pam
	dev-libs/libgcrypt:0=
"
RDEPEND="
	${DEPEND}
	net-misc/socat
"
