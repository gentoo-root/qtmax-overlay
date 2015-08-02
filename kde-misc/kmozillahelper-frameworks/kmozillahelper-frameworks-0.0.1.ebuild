# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Firefox KDE integration, unofficial KF5 port"
HOMEPAGE="https://build.opensuse.org/package/show/openSUSE:Factory/mozilla-kde4-integration"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep extra-cmake-modules)
"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${S}"
	cp "${FILESDIR}/${PV}/kmozillahelper.notifyrc" \
	   "${FILESDIR}/${PV}/CMakeLists.txt" \
	   "${FILESDIR}/${PV}/main.cpp" \
	   "${FILESDIR}/${PV}/main.h" \
	   "${S}"
}
