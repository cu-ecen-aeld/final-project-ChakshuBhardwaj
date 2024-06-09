IMAGE_CLASSES:append = " image_type_tezi"
IMAGE_FSTYPES:append = " teziimg"
# The payload offsets are given in number of 512 byte blocks.
OFFSET_BOOTROM_PAYLOAD = "2"
TORADEX_PRODUCT_IDS = "0062"
TORADEX_FLASH_TYPE = "emmc"

WIC_CREATE_EXTRA_ARGS:append = " --no-fstab-update"

MACHINE_NAME = "Colibri-iMX6ULL-eMMC"

IMX_DEFAULT_BOOTLOADER:colibri-imx6ull-emmc = "u-boot"
PREFERRED_PROVIDER_u-boot-default-script = "u-boot-distro-boot"
UBOOT_MAKE_TARGET:colibri-imx6ull-emmc = "u-boot.imx"
UBOOT_SUFFIX:colibri-imx6ull-emmc = "imx"
UBOOT_ENTRYPOINT:colibri-imx6ull-emmc = "0x81000000"
UBOOT_DTB_LOADADDRESS:colibri-imx6ull-emmc = "0x82100000"
UBOOT_DTBO_LOADADDRESS:colibri-imx6ull-emmc = "0x87000000"

TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT = "colibri-imx6ull_parallel-rgb_vga_overlay.dtbo colibri-imx6ull_ad7879_overlay.dtbo"
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT:use-mainline-bsp = "colibri-imx6ull_parallel-rgb_overlay.dtbo colibri-imx6ull_ad7879_overlay.dtbo display-vga_overlay.dtbo"

PREFERRED_PROVIDER_virtual/kernel = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:preempt-rt = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp:preempt-rt = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/dtb:use-mainline-bsp = "device-tree-overlays-mainline"
