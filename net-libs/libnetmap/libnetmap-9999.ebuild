# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A framework for very fast packet I/O from userspace"
HOMEPAGE="https://github.com/luigirizzo/netmap"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/luigirizzo/netmap.git"

	inherit git-r3
else
	# TODO: versioned netmap?
	SRC_URI=""
fi

LICENSE="BSD-2"
SLOT="0"
if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64-linux"
fi

src_prepare () {
	cp "${FILESDIR}/CMakeLists.txt" "${S}"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
	)

	cmake_src_configure
}
