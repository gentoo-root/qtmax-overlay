# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bzr cmake-utils

DESCRIPTION="A simple shared library that produces and stores thumbnails"
HOMEPAGE="https://launchpad.net/thumbnailer"
EBZR_REPO_URI="lp:thumbnailer"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2:2
	dev-qt/qtcore:5
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/libexif
	net-libs/libsoup:2.4
	x11-libs/gdk-pixbuf:2
"
DEPEND="${RDEPEND}"
