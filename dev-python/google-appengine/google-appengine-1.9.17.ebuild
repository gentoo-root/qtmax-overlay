# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Google App Engine SDK for Python"
HOMEPAGE="http://appengine.google.com/"
SRC_URI="https://storage.googleapis.com/appengine-sdks/featured/${PN/-/_}_${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE_LINGUAS="ar az bg bn bs ca cs cy da de el en en_GB eo es es_AR
es_MX et eu fa fi fr fy_NL ga gl he hi hr hu id is it ja ka kk km kn
ko lt lv mk ml mn nb ne nl nn no pa pl pt pt_BR ro ru sk sl sq sr
sr_Latn sv sw ta te th tr tt uk ur vi zh_CN zh_TW"

IUSE="examples $(printf 'linguas_%s ' ${IUSE_LINGUAS})"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/${PN/-/_}"

src_prepare() {
	python_fix_shebang *.py

	einfo "Removing unnecessary translations..."
	# remove loooots of unnecessary translations
	for l in $IUSE_LINGUAS; do
		if [ "${l}" != "en" ] && ! use linguas_${l} ; then
			find -depth -type d -name "${l}" -exec rm -r {} \; > /dev/null
		fi
	done
}

src_install() {
	python_moduleinto /opt/${PN}
	python_domodule google

	insinto /opt/${PN}
	doins -r lib tools VERSION || die "install failed"

	if use examples ; then
		insinto /opt/${PN}/examples
		doins -r demos new_project_template || die "install examples failed"
	fi

	exeinto /opt/${PN}
	doexe *.py
	dodoc BUGS README RELEASE_NOTES
}
