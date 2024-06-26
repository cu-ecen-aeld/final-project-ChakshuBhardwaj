HOMEPAGE = "https://developer.nvidia.com/embedded"
LICENSE = "Proprietary"

L4T_DEB_COPYRIGHT_MD5 ??=""
L4T_DEB_TRANSLATED_BPN ?= "${@d.getVar('BPN').replace('tegra-libraries-', 'nvidia-l4t-')}"
LIC_FILES_CHKSUM = "file://usr/share/doc/${L4T_DEB_TRANSLATED_BPN}/copyright;md5=${L4T_DEB_COPYRIGHT_MD5}"

COMPATIBLE_MACHINE = "(tegra186|tegra194)"
COMPATIBLE_MACHINE:tegra210 = "(tegra210)"
TEGRA_LIBRARIES_CONTAINER_CSV ?= "container-runtime-csv"

inherit l4t_deb_pkgfeed ${TEGRA_LIBRARIES_CONTAINER_CSV}

SRC_SOC_DEBS = "${L4T_DEB_TRANSLATED_BPN}_${PV}_arm64.deb;subdir=${BP};name=main"
SRC_URI[main.sha256sum] = "${MAINSUM}"

PV = "${L4T_VERSION}${@l4t_bsp_debian_version_suffix(d)}"

install_libraries() {
    install -d ${D}${libdir}
    for f in ${TEGRA_LIBRARIES_TO_INSTALL}; do
        fbasename=$(basename "$f")
	install -m 0644 ${S}/usr/lib/aarch64-linux-gnu/$f ${D}${libdir}/$fbasename
    done
}

do_configure() {
    :
}

do_compile() {
    :
}

do_install() {
    install_libraries
}

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_SYSROOT_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INSANE_SKIP = "dev-so ldflags"

CONTAINER_CSV_FILES = "${libdir}/*.so*"

PACKAGE_ARCH = "${L4T_BSP_PKGARCH}"
