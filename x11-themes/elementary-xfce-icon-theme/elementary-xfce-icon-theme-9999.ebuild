# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils git-r3

DESCRIPTION="Elementary icons forked from upstream, extended and maintained for Xfce"
HOMEPAGE="https://github.com/shimmerproject/elementary-xfce"
EGIT_REPO_URI="https://github.com/shimmerproject/elementary-xfce.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND=""

RESTRICT="binchecks mirror strip"

DIRS=( elementary-xfce-dark elementary-xfce-darker elementary-xfce-darkest elementary-xfce )
DOCS=( AUTHORS CONTRIBUTORS LICENSE )

src_install() {
	for dir in "${DIRS[@]}"; do
		docinto "${dir}"
		cd "${dir}"
		dodoc "${DOCS[@]}"
		rm "${DOCS[@]}"
		cd ..
	done

	insinto /usr/share/icons
	doins -r "${DIRS[@]}"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
