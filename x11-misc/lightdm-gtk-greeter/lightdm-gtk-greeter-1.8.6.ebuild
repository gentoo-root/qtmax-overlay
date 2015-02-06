# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm-gtk-greeter/lightdm-gtk-greeter-1.9.0.ebuild,v 1.1 2014/09/07 19:40:08 hwoarang Exp $

EAPI=4

inherit autotools bzr versionator

DESCRIPTION="LightDM GTK+ Greeter"
HOMEPAGE="http://launchpad.net/lightdm-gtk-greeter"
EBZR_REPO_URI="lp:lightdm-gtk-greeter/1.8"
EBZR_BRANCH="1.8"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2.2"
RDEPEND="!!<x11-misc/lightdm-1.1.1
	x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2.2
	x11-themes/gnome-themes-standard
	x11-themes/gnome-icon-theme"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --enable-maintainer-mode
}
