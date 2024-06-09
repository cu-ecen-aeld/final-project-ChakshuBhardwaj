require u-boot-toradex-common.inc
require recipes-bsp/u-boot/u-boot.inc

B = "${WORKDIR}/build"

PROVIDES += "u-boot"

DEPENDS += "bc-native dtc-native"

# While NXP i.MX 7 downstream requires the Linux kernel to boot in secure
# mode mainline/upstream requires non-secure mode instead, as it properly
# uses PSCI to control further cores.
SRC_URI:append:use-mainline-bsp:colibri-imx7 = " file://0001-colibri_imx7-boot-linux-kernel-in-non-secure-mode.patch"
SRC_URI:append:use-mainline-bsp:colibri-imx7-emmc = " file://0001-colibri_imx7-boot-linux-kernel-in-non-secure-mode.patch"

BOOT_TOOLS = "imx-boot-tools"

PADDING_DIR = "${B}"

nand_padding () {
    # pad the end of U-Boot with 0x00 up to the the end of the CSF area
    #PAD_END=$(echo -n "0x"; od -X  -j 0x24 -N 4 u-boot.imx | sed -e '/................/!d' -e 's/........\(.*\)/\1/')
    #PAD_END=$(( $PAD_END - 0x400 ))
    #objcopy -I binary -O binary --pad-to $PAD_END u-boot.imx u-boot.imx.zero-padded
    # assume that the above never need more than 10k of padding and skip the
    # shell magic to get a correct size.
    dd bs=10k count=1 if=/dev/zero | cat ${PADDING_DIR}/u-boot.imx - > ${PADDING_DIR}/u-boot.imx.zero-padded

    # U-Boot is flashed 1k into a NAND block, create a binary which prepends
    # U-boot with 1k of zeros to ease flashing
    dd bs=1024 count=1 if=/dev/zero | cat - ${PADDING_DIR}/u-boot.imx.zero-padded > ${PADDING_DIR}/u-boot-nand.imx
}

deploy_uboot_with_spl () {
    for config in ${UBOOT_MACHINE}; do
        if [ -f "${B}/${config}/u-boot-with-spl.imx" ]; then
            install -D -m 644 ${B}/${config}/u-boot-with-spl.imx ${DEPLOYDIR}/u-boot-with-spl.imx
        fi
    done
}

do_compile:append:colibri-imx6ull () {
    nand_padding
}

do_compile:append:colibri-imx7 () {
    nand_padding
}

do_compile:append:colibri-vf () {
    nand_padding
}

do_deploy:append:colibri-imx6 () {
    deploy_uboot_with_spl
}

do_deploy:append:apalis-imx6 () {
    deploy_uboot_with_spl
}
