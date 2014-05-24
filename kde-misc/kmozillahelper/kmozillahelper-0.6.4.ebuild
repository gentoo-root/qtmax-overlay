# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="Mozilla KDE Integration"
HOMEPAGE="http://en.opensuse.org/KDE/FirefoxIntegration"
SRC_URI="https://build.opensuse.org/source/openSUSE:Factory/mozilla-kde4-integration/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=kde-base/kdelibs-4.2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
