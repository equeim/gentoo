# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="https://oidentd.janikrabe.com/"
SRC_URI="https://files.janikrabe.com/pub/${PN}/releases/${PV}/${P}.tar.xz"

LICENSE="BSD-2 GPL-2 LGPL-2+"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~mips ppc ppc64 ~s390 ~sparc x86"
IUSE="debug masquerade selinux"

DEPEND="masquerade? ( net-libs/libnetfilter_conntrack )"

RDEPEND="
	${DEPEND}
	acct-user/oidentd
	acct-group/oidentd
	selinux? ( sec-policy/selinux-oident )
"

BDEPEND="
	app-alternatives/yacc
	app-alternatives/lex
"

src_prepare() {
	sed -i '/ExecStart/ s|$| -u oidentd -g oidentd|' contrib/systemd/*.service || die

	default
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable masquerade libnfct)
		$(use_enable masquerade nat)
		--enable-ipv6
		--enable-xdgbdir
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	newinitd "${FILESDIR}"/${PN}-2.0.7-init ${PN}
	newconfd "${FILESDIR}"/${PN}-2.2.2-confd ${PN}

	systemd_dounit contrib/systemd/${PN}@.service
	systemd_dounit contrib/systemd/${PN}.socket
	systemd_dounit contrib/systemd/${PN}.service
}
