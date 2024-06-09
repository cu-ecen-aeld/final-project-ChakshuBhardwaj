IMX_FIRMWARE_SRC ?= "git://github.com/NXP/imx-firmware.git;protocol=https"
SRCBRANCH_imx-firmware = "lf-5.10.72_2.2.0"
SRC_URI += " \
    ${IMX_FIRMWARE_SRC};branch=${SRCBRANCH_imx-firmware};destsuffix=imx-firmware;name=imx-firmware \
"

SRCREV_imx-firmware = "a312213179f671cecba5f32aa839cc752a3e817f"

SRCREV_FORMAT = "default_imx-firmware"

do_install:append () {
    # Install NXP Connectivity SDIO8997 firmware
    install -d ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/wifi_mod_para.conf                        ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8997_SD/ed_mac_ctrl_V3_8997.conf  ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8997_SD/sdiouart8997_combo_v4.bin ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8997_SD/txpwrlimit_cfg_8997.conf  ${D}${nonarch_base_libdir}/firmware/nxp

    # Upstream SDIO8997 driver firmware is located elsewhere
    install -d ${D}${nonarch_base_libdir}/firmware/mrvl
    ln -frs ${D}${nonarch_base_libdir}/firmware/nxp/sdiouart8997_combo_v4.bin ${D}${nonarch_base_libdir}/firmware/mrvl/sdiouart8997_combo_v4.bin
}

PACKAGES =+ " ${PN}-nxp89xx"

FILES:${PN}-nxp89xx = " \
       ${nonarch_base_libdir}/firmware/nxp/*  \
       ${nonarch_base_libdir}/firmware/mrvl/sdiouart8997_combo_v4.bin \
"
