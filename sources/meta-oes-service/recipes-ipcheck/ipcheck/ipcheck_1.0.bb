SUMMARY = "ip check service"
DESCRIPTION = "Custom service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"


SRC_URI += "file://ip_check.service \
            "

S = "${WORKDIR}"

do_install() {

    	install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/ip_check.service ${D}${systemd_unitdir}/system/
}


INSANE_SKIP:${PN} += " already-stripped"
RDEPENDS:${PN} += "bash"

SYSTEMD_SERVICE:${PN} = "ip_check.service"


FILES:${PN} += "${systemd_unitdir}/system/"
FILES:${PN} += "${systemd_unitdir}/system/ip_check.service"

FILES:${PN} += "/lib/systemd/system"

REQUIRED_DISTRO_FEATURES= "systemd"
