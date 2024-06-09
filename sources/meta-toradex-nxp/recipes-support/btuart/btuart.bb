SUMMARY = "Initialize Bluetooth UART"
DESCRIPTION = "At runtime on target make sure appropriate firmware is used and initialize Bluetooth UART"
LICENSE = "PD"

PACKAGE_ARCH = "${MACHINE_ARCH}"

RRECOMMENDS_${PN} = "bluez5"

SRC_URI = " \
    file://btuart.sh \
    file://btuart.service \
    file://COPYING \
"

LIC_FILES_CHKSUM = "file://${WORKDIR}/COPYING;md5=1c3a7fb45253c11c74434676d84fe7dd"

do_install () {
    install -d ${D}/${sbindir}
    install -m 0755 ${WORKDIR}/*.sh ${D}/${sbindir}

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/btuart.service ${D}${systemd_unitdir}/system
}

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "btuart.service"

inherit allarch systemd

pkg_postinst_ontarget_${PN}_verdin-imx8mp () {
    # only BT UART modules need our service
    if fgrep -q V1.0 /proc/device-tree/toradex,board-rev || ! fgrep -q toradex,verdin-imx8mp-wifi /proc/device-tree/compatible; then
        /bin/systemctl disable btuart.service
        /bin/systemctl stop btuart.service
        exit 0
    fi
}
