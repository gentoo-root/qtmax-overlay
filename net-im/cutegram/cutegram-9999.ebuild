# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit fdo-mime git-r3 gnome2-utils qmake-utils

DESCRIPTION="Telegram client by Aseman Land"
HOMEPAGE="http://aseman.co/cutegram"
EGIT_REPO_URI="https://github.com/Aseman-Land/Cutegram.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/openssl
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtmultimedia:5
	dev-qt/qtquick1:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtwidgets:5
	net-im/libqtelegram
	sys-libs/zlib
"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
