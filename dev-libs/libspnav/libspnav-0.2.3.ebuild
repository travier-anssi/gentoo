# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit multilib toolchain-funcs

MY_PN='spacenav'
DESCRIPTION="libspnav is a replacement for the magellan library with a cleaner API"
HOMEPAGE="http://spacenav.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${MY_PN}/${MY_PN}%20library%20%28SDK%29/${PN}%20${PV}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="X"

CDEPEND="X? ( x11-libs/libX11 )"
RDEPEND="app-misc/spacenavd[X?]
	${CDEPEND}"
DEPEND="${CDEPEND}"

src_prepare() {
	eapply "${FILESDIR}"/${P}-makefile.patch
	eapply_user
}

src_configure() {
	local args=(
		--disable-opt
		--disable-debug
		$(use_enable X x11)
	)
	econf "${args[@]}"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	local args=(
		DESTDIR="${D}"
		libdir="$(get_libdir)"
	)
	emake "${args[@]}" install
}
