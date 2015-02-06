# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.11.0-r2.ebuild,v 1.3 2014/07/24 10:54:57 ssuominen Exp $

EAPI=5
inherit xfconf

DESCRIPTION="A session manager for the Xfce desktop environment"
HOMEPAGE="http://docs.xfce.org/xfce/xfce4-session/start"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug nls +xscreensaver"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.100
	x11-apps/iceauth
	x11-libs/libSM
	>=x11-libs/libwnck-2.30:1
	x11-libs/libX11
	>=xfce-base/libxfce4util-4.11
	>=xfce-base/libxfce4ui-4.11
	>=xfce-base/xfconf-4.10
	!xfce-base/xfce-utils"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xrdb
	nls? ( x11-misc/xdg-user-dirs )
	xscreensaver? ( || (
		>=x11-misc/xscreensaver-5.26
		gnome-extra/gnome-screensaver
		>=x11-misc/xlockmore-5.43
		x11-misc/slock
		x11-misc/alock[pam]
		) )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--with-xsession-prefix="${EPREFIX}"/usr
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS BUGS ChangeLog NEWS README TODO )
}

src_install() {
	xfconf_src_install

	local sessiondir=/etc/X11/Sessions
	echo startxfce4 > "${T}"/Xfce4
	exeinto ${sessiondir}
	doexe "${T}"/Xfce4
	dosym Xfce4 ${sessiondir}/Xfce
}
