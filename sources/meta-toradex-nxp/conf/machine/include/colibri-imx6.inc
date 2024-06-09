IMAGE_CLASSES:append = " image_type_tezi"
IMAGE_FSTYPES:append = " teziimg"
TORADEX_PRODUCT_IDS = "0014 0015 0016 0017"
# The payload offsets are given in number of 512 byte blocks.
OFFSET_BOOTROM_PAYLOAD = "2"
OFFSET_SPL_PAYLOAD = "138"

MACHINE_NAME = "Colibri-iMX6"

TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT = "colibri-imx6_lcd-vga_overlay.dtbo colibri-imx6_stmpe-ts_overlay.dtbo"
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT:use-mainline-bsp = "colibri-imx6_parallel-rgb_overlay.dtbo colibri-imx6_stmpe-ts_overlay.dtbo display-vga_overlay.dtbo"

KERNEL_DEVICETREE += " \
    imx6dl-colibri-iris.dtb \
    imx6dl-colibri-iris-v2.dtb \
"

PREFERRED_PROVIDER_virtual/kernel = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:preempt-rt = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp:preempt-rt = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/dtb:use-mainline-bsp = "device-tree-overlays-mainline"

IMX_DEFAULT_BOOTLOADER:colibri-imx6 = "u-boot"
PREFERRED_PROVIDER_u-boot-default-script = "u-boot-distro-boot"
UBOOT_SUFFIX = "img"

MACHINE_FIRMWARE:remove = "firmware-imx-epdc"

UBOOT_ENTRYPOINT:colibri-imx6 = "0x11000000"
UBOOT_DTB_LOADADDRESS:colibri-imx6 = "0x12100000"
UBOOT_DTBO_LOADADDRESS:colibri-imx6 = "0x17000000"
