# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

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

IUSE="+extmem +generic +monitor +pipe -ptnetmap -sink +vale"

MODULE_NAMES="netmap(misc)"

src_prepare() {
	default_src_prepare

	sed -i -e 's/netmap.ko/module/g' ${S}/LINUX/netmap.mak.in
}

src_configure() {
	set_arch_to_kernel
	${S}/configure \
		--cc=$(get-KERNEL_CC) \
		--kernel-dir="${KERNEL_DIR}" \
		--kernel-sources="${KERNEL_DIR}" \
		--driver-suffix="_netmap" \
		--prefix="${EPREFIX}/usr" \
		--install-mod-path="${EPREFIX}" \
		${EXTRA_ECONF} \
		--no-apps \
		--no-drivers \
		--no-utils \
		$(use_enable extmem) \
		$(use_enable generic) \
		$(use_enable monitor) \
		$(use_enable pipe) \
		$(use_enable ptnetmap) \
		$(use_enable sink) \
		$(use_enable vale) \
	|| die
	set_arch_to_pkgmgr
}

