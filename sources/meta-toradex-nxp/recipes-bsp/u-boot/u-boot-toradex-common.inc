HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
SECTION = "bootloaders"
DEPENDS += "flex-native bison-native"

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"
PE = "1"

PV = "2020.07+git${SRCPV}"

inherit toradex-u-boot-localversion

# We use the revision in order to avoid having to fetch it from the
# repo during parse
SRCREV = "1cbeecee44a868f4ace933a992e730efb6d9d654"
SRCBRANCH = "toradex_2020.07"
SRCREV:use-head-next = "${AUTOREV}"

SRC_URI = " \
    git://git.toradex.com/u-boot-toradex.git;protocol=https;branch=${SRCBRANCH} \
    file://fw_env.config \
"

S = "${WORKDIR}/git"

UBOOT_INITIAL_ENV = "u-boot-initial-env"

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
