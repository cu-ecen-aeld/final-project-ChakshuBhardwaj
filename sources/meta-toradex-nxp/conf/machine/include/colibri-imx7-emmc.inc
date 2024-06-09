IMAGE_CLASSES:append = " image_type_tezi"
IMAGE_FSTYPES:append = " teziimg"
# The payload offsets are given in number of 512 byte blocks.
OFFSET_BOOTROM_PAYLOAD = "2"
TORADEX_PRODUCT_IDS = "0039"
TORADEX_FLASH_TYPE = "emmc"

MACHINE_NAME = "Colibri-iMX7-eMMC"

MACHINE_FIRMWARE:remove = "firmware-imx-epdc"
MACHINE_FIRMWARE:remove:use-mainline-bsp = "firmware-imx-vpu-imx6q firmware-imx-vpu-imx6d"

PREFERRED_PROVIDER_virtual/kernel = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:preempt-rt = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp:preempt-rt = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/dtb:use-mainline-bsp = "device-tree-overlays-mainline"

KERNEL_DEVICETREE:append:use-nxp-bsp = " \
    imx7d-colibri-emmc-iris.dtb \
    imx7d-colibri-emmc-iris-v2.dtb \
"
KERNEL_DEVICETREE:append:use-mainline-bsp = " \
    imx7d-colibri-emmc-aster.dtb \
"

IMX_DEFAULT_BOOTLOADER:colibri-imx7-emmc = "u-boot"
PREFERRED_PROVIDER_u-boot-default-script = "u-boot-distro-boot"

TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT = "colibri-imx7_lcd-vga_overlay.dtbo colibri-imx7_ad7879_overlay.dtbo"
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT:use-mainline-bsp = "colibri-imx7_parallel-rgb_overlay.dtbo colibri-imx7_ad7879_overlay.dtbo display-vga_overlay.dtbo"

UBOOT_BINARY:colibri-imx7-emmc = "u-boot.imx"
UBOOT_DTB_LOADADDRESS:colibri-imx7-emmc = "0x82000000"
UBOOT_DTBO_LOADADDRESS:colibri-imx7-emmc = "0x87000000"
UBOOT_ENTRYPOINT:colibri-imx7-emmc = "0x81000000"
UBOOT_MAKE_TARGET = "u-boot.imx"
UBOOT_SUFFIX:${MACHINE} = "imx"
