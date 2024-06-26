inherit image_types_tegra

UBOOT_BOOTIMG_BOARD ?= "/dev/mmcblk0p1"

uboot_make_bootimg() {
    rm -f ${B}/initrd
    touch ${B}/initrd
    if [ -n "${UBOOT_CONFIG}" ]; then
        unset i j k
	for config in ${UBOOT_MACHINE}; do
	    i=$(expr $i + 1)
	    for type in ${UBOOT_CONFIG}; do
	        j=$(expr $j + 1)
	        if [ $j -eq $i ]; then
	            for binary in ${UBOOT_BINARIES}; do
		        k=$(expr $k + 1)
		        if [ $k -eq $i ]; then
		            f="${B}/${config}/u-boot-${type}.${UBOOT_SUFFIX}"
		            rm -f $f
			    ${STAGING_BINDIR_NATIVE}/${SOC_FAMILY}-flash/mkbootimg \
			        --kernel ${B}/${config}/${binary} --ramdisk ${B}/initrd --cmdline "" \
			        --board "${UBOOT_BOOTIMG_BOARD}" --output $f
			fi
		    done
		    unset k
		fi
	    done
	    unset j
	done
	unset i
    else
        mv ${UBOOT_BINARY} ${UBOOT_BINARY}.orig
	${STAGING_BINDIR_NATIVE}/${SOC_FAMILY}-flash/mkbootimg \
	    --kernel ${UBOOT_BINARY}.orig --ramdisk ${B}/initrd --cmdline "" \
	    --board "${UBOOT_BOOTIMG_BOARD}" --output ${UBOOT_BINARY}
    fi
}

do_compile:append:tegra() {
    uboot_make_bootimg
}

do_install:append:tegra() {
    if [ -n "${INITRAMFS_IMAGE}" -a "${INITRAMFS_IMAGE_BUNDLE}" != "1" ]; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/${INITRAMFS_IMAGE}-${MACHINE}.cpio.gz ${D}/boot/initrd
    fi
}

EXTRADOINSTDEPS = ""
EXTRADOINSTDEPS:tegra = "${@'${INITRAMFS_IMAGE}:do_image_complete' if d.getVar('INITRAMFS_IMAGE') != '' and d.getVar('INITRAMFS_IMAGE_BUNDLE') != '1' else ''}"
do_install[depends] += "${EXTRADOINSTDEPS}"
