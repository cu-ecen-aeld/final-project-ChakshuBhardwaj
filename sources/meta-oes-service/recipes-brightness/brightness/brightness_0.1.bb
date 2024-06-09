SUMMARY = "service"
DESCRIPTION = "Custom service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"


SRC_URI += "file://brightness.service \
           "

S = "${WORKDIR}"

do_install() {

    	#install -d ${D}${systemd_unitdir}/system
        #install -m 0644 ${WORKDIR}/ip_check.service ${D}${systemd_unitdir}/system/

        install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/brightness.service ${D}${systemd_unitdir}/system/

        #install -d ${D}${systemd_unitdir}/system
	#install -m 0644 ${WORKDIR}/startup.service ${D}${systemd_unitdir}/system/

	
}


INSANE_SKIP:${PN} += " already-stripped"
RDEPENDS:${PN} += "bash"

#SYSTEMD_SERVICE_${PN} = "startup.service"
SYSTEMD_SERVICE:${PN} = "brightness.service"
#SYSTEMD_SERVICE_${PN} = "ip_check.service"


FILES:${PN} += "${systemd_unitdir}/system/"
FILES:${PN} += "${systemd_unitdir}/system/brightness.service"
#FILES_${PN} += "${systemd_unitdir}/system/"
#FILES_${PN} += "${systemd_unitdir}/system/ip_check.service"
#FILES_${PN} += "${systemd_unitdir}/system/"
#FILES_${PN} += "${systemd_unitdir}/system/startup.service"

FILES:${PN} += "/lib/systemd/system"
#FILES_${PN} += "${libdir}/*"
#FILES_${PN}-dev = "${libdir}/* ${includedir}"

REQUIRED_DISTRO_FEATURES= "systemd"
