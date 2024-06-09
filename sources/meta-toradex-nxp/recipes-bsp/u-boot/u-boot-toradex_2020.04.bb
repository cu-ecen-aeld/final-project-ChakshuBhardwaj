require recipes-bsp/u-boot/u-boot.inc
require u-boot-toradex-common_${PV}.inc

SUMMARY = "U-Boot bootloader with support for Toradex i.MX 8 series SoMs"

B = "${WORKDIR}/build"

PROVIDES += "u-boot"
DEPENDS:append = " dtc-native"

BOOT_TOOLS = "imx-boot-tools"
