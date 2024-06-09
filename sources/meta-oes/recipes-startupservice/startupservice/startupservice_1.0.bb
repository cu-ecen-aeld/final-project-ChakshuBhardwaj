SUMMARY = "startupservice"
DESCRIPTION = "Custom service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
#inherit externalsrc

inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"


SRC_URI += "file://usb_firmware_upgrade.sh \
           file://5-usb-detect.rules \
	   file://oes_ota.log \
	   file://oesc_fwver \
	   file://ip_check.sh \
	   file://brightnessControl.sh \
	   file://new_fw_check.sh \
	   file://OESDatabase.db \
	   file://oesStart.sh \
	   file://startup.service \
	   file://emmc_flash.sh \
	   file://AppOnly.sh"

S = "${WORKDIR}"

do_install() {

	install -d ${D}/home/root/
        install -m 0777 usb_firmware_upgrade.sh ${D}/home/root
        install -m 0777 emmc_flash.sh ${D}/home/root
	install -m 0777 AppOnly.sh ${D}/home/root

        install -d ${D}/etc/udev/rules.d/ 
        install -m 0777 5-usb-detect.rules ${D}/etc/udev/rules.d
	
	install -d ${D}/var/logs
        install -m 0777 oes_ota.log ${D}/var/logs
        
	install -d ${D}/home/vvdn
        install -m 0777 OESDatabase.db ${D}/home/vvdn
	
	
	install -d ${D}/etc/
        install -m 0777 ip_check.sh ${D}/etc/	
        install -m 0777 brightnessControl.sh ${D}/etc/
        install -m 0777 new_fw_check.sh ${D}/etc/
        install -m 0777 oesc_fwver ${D}/etc/
        install -m 0777 oesStart.sh ${D}/etc/
       
	install -d ${D}/etc/cron.hourly

	install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/startup.service ${D}${systemd_unitdir}/system/
}


INSANE_SKIP:${PN} += "already-stripped"
RDEPENDS:${PN} += "bash"

SYSTEMD_SERVICE:${PN} = "startup.service"

FILES:${PN} += "/home/root"
FILES:${PN} += "/home/root/usb_firmware_upgrade.sh"
FILES:${PN} += "/home/root/emmc_flash.sh"
FILES:${PN} += "/etc/udev/rules.d"
FILES:${PN} += "/etc/udev/rules.d/5-usb-detect.rules"
FILES:${PN} += "/var/logs"
FILES:${PN} += "/var/logs/oes_ota.log"
FILES:${PN} += "/home/vvdn"
FILES:${PN} += "/home/vvdn/OESDatabase.db"
FILES:${PN} += "/etc/"
FILES:${PN} += "/etc/ip_check.sh"
FILES:${PN} += "/etc/brightnessControl.sh"
FILES:${PN} += "/etc/new_fw_check.sh"
FILES:${PN} += "/etc/oesc_fwver"
FILES:${PN} += "/etc/oesStart.sh"
FILES:${PN} += "/etc/cron.hourly"
FILES:${PN} += "/etc/logrotate"

FILES:${PN} += "${systemd_unitdir}/system/"
FILES:${PN} += "${systemd_unitdir}/system/startup.service"

FILES:${PN} += "/lib/systemd/system"

REQUIRED_DISTRO_FEATURES= "systemd"


