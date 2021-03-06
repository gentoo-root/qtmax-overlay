# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/v4l2loopback/v4l2loopback-0.8.0.ebuild,v 1.1 2014/03/04 21:42:45 naota Exp $

EAPI=4

inherit git-r3 linux-mod

DESCRIPTION="v4l2 loopback device which output is it's own input"
HOMEPAGE="https://github.com/umlaeute/v4l2loopback"
EGIT_REPO_URI="https://github.com/umlaeute/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

CONFIG_CHECK="VIDEO_DEV"
MODULE_NAMES="v4l2loopback(video:)"
BUILD_TARGETS="all"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	linux-mod_src_compile
	if use examples; then
		cd "${S}"/examples
		emake
	fi
}

src_install() {
	linux-mod_src_install
	dosbin utils/v4l2loopback-ctl
	dodoc doc/*
	if use examples; then
		dosbin examples/yuv4mpeg_to_v4l2
		docinto examples
		dodoc examples/{*.sh,*.c,Makefile}
	fi
}
