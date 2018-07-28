# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3

DESCRIPTION="a terminal emulator based off of libvte that aims to be fast and lightweight"
HOMEPAGE="https://lilyterm.luna.com.tw"
EGIT_REPO_URI="https://github.com/Tetralet/LilyTerm"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS=""

RDEPEND="
	x11-libs/vte:0
"
DEPEND="
	${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

DOCS=( AUTHORS ChangeLog README TODO )

src_prepare() {
	default

	./autogen.sh || die
}
