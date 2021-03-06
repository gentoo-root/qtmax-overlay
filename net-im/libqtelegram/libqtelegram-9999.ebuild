# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bzr cmake-utils

DESCRIPTION="Qt asynchronous library to be used as Telegram client"
HOMEPAGE="https://launchpad.net/libqtelegram"
EBZR_REPO_URI="lp:libqtelegram"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/openssl
	dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	media-gfx/thumbnailer
	media-libs/libmediainfo
"
DEPEND="${RDEPEND}"

src_prepare() {
	# some header files were moved to lib/util
	sed -i -r -e '/^    (asserter|constants|cryptoutils|tlvalues)\.h$/d' \
	          -e 's/^    utils\.h\)$/)/' lib/core/CMakeLists.txt

	if use test; then
		echo 'add_dependencies(${LIBQTELEGRAM_TESTS_TARGET} ${GTEST_LIBRARY})' >> tests/CMakeLists.txt
	else
		sed -i -e '/^add_subdirectory(tests)$/d' CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DQT_IMPORTS_DIR=$(get_libdir)/qt5/qml
	)

	cmake-utils_src_configure
}
