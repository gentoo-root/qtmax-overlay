# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DB_VER="4.8"

LANGS="af_ZA ar bg bs ca ca_ES cs cy da de el_GR en eo es es_CL et eu_ES fa fa_IR fi fr fr_CA gu_IN he hi_IN hr hu it ja la lt lv_LV nb nl pl pt_BR pt_PT ro_RO ru sk sr sv th_TH tr uk zh_CN zh_TW"
inherit db-use eutils fdo-mime git-r3 gnome2-utils kde4-functions qt4-r2

DESCRIPTION="Scrypt cryptocurrency with changing N-factor"
HOMEPAGE="https://cryptocointalk.com/topic/14319-aptcoin-apt-information/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/aptcoin/aptcoin.git"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CC-BY-SA-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus ipv6 +qrcode upnp"
#IUSE="dbus ipv6 kde +qrcode upnp"

RDEPEND="
	dev-libs/boost[threads(+)]
	dev-libs/openssl:0[-bindist]
	qrcode? (
		media-gfx/qrencode
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	dev-qt/qtgui:4
	dbus? (
		dev-qt/qtdbus:4
	)
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

DOCS="doc/README.md doc/release-notes.md"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	local filt= yeslang= nolang=

	for lan in $LANGS; do
		if [ ! -e src/qt/locale/aptcoin_$lan.ts ]; then
			ewarn "Language '$lan' no longer supported. Ebuild needs update."
		fi
	done

	for ts in $(ls src/qt/locale/*.ts)
	do
		x="${ts/*aptcoin_/}"
		x="${x/.ts/}"
		if ! use "linguas_$x"; then
			nolang="$nolang $x"
			rm "$ts"
			filt="$filt\\|$x"
		else
			yeslang="$yeslang $x"
		fi
	done

	filt="aptcoin_\\(${filt:2}\\)\\.\(qm\|ts\)"
	sed "/${filt}/d" -i 'src/qt/aptcoin.qrc'
	einfo "Languages -- Enabled:$yeslang -- Disabled:$nolang"
}

src_configure() {
	OPTS=()

	use dbus && OPTS+=("USE_DBUS=1")
	if use upnp; then
		OPTS+=("USE_UPNP=1")
	else
		OPTS+=("USE_UPNP=-")
	fi

	use qrcode && OPTS+=("USE_QRCODE=1")
	use ipv6 || OPTS+=("USE_IPV6=-")

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	if has_version '>=dev-libs/boost-1.52'; then
		OPTS+=("LIBS+=-lboost_chrono\$\$BOOST_LIB_SUFFIX")
	fi

	eqmake4 aptcoin-qt.pro "${OPTS[@]}"
}

src_install() {
	qt4-r2_src_install

	dobin ${PN}

	insinto /usr/share/pixmaps
	newins "share/pixmaps/bitcoin.ico" "${PN}.ico"

	make_desktop_entry "${PN} %u" "Aptcoin-Qt" "/usr/share/pixmaps/${PN}.ico" "Qt;Network;P2P;Office;Finance;" "MimeType=x-scheme-handler/aptcoin;\nTerminal=false"

#	newman contrib/debian/manpages/bitcoin-qt.1 ${PN}.1

#	if use kde; then
#		insinto /usr/share/kde4/services
#		newins contrib/debian/bitcoin-qt.protocol ${PN}.protocol
#	fi
}

update_caches() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
	buildsycoca
}

pkg_postinst() {
	update_caches
}

pkg_postrm() {
	update_caches
}
