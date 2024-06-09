HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
SECTION = "bootloaders"
DEPENDS += "flex-native bison-native"

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = " \
    git://git.toradex.com/u-boot-toradex.git;protocol=https;branch=${SRCBRANCH} \
    file://fw_env.config \
"

SRCREV = "91a1b19e7384c0eca4ed96a0cae16d2f7d95fbb7"
SRCREV:use-head-next = "${AUTOREV}"
SRCBRANCH = "toradex_imx_v2020.04_5.4.70_2.3.0"

S = "${WORKDIR}/git"

inherit toradex-u-boot-localversion

UBOOT_INITIAL_ENV = "u-boot-initial-env"

COMPATIBLE_MACHINE = "(mx8-generic-bsp)"
PACKAGE_ARCH = "${MACHINE_ARCH}"

do_deploy:append:mx8m-generic-bsp() {
    # Deploy the u-boot-nodtb.bin and fsl-imx8m*-XX.dtb for mkimage to generate boot binary
    if [ -n "${UBOOT_CONFIG}" ]
    then
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]
                then
                    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
                    install -m 0777 ${B}/${config}/arch/arm/dts/${UBOOT_DTB_NAME}  ${DEPLOYDIR}/${BOOT_TOOLS}
                    install -m 0777 ${B}/${config}/u-boot-nodtb.bin  ${DEPLOYDIR}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${UBOOT_CONFIG}
                fi
            done
            unset  j
        done
        unset  i
    fi
}
