IMAGE_CLASSES:append = " image_type_tezi"
IMAGE_FSTYPES:append = " teziimg"
TORADEX_PRODUCT_IDS = "0036 0040 0044 0045"
TORADEX_PRODUCT_IDS[0036] = "imx6ull-colibri-eval-v3.dtb"
TORADEX_PRODUCT_IDS[0040] = "imx6ull-colibri-wifi-eval-v3.dtb"
TORADEX_PRODUCT_IDS[0044] = "imx6ull-colibri-eval-v3.dtb"
TORADEX_PRODUCT_IDS[0045] = "imx6ull-colibri-wifi-eval-v3.dtb"
TORADEX_FLASH_TYPE = "rawnand"

WIC_CREATE_EXTRA_ARGS:append = " --no-fstab-update"

MACHINE_NAME = "Colibri-iMX6ULL"

MACHINE_FIRMWARE:remove:use-mainline-bsp = "firmware-imx-vpu-imx6q firmware-imx-vpu-imx6d"

IMX_DEFAULT_BOOTLOADER:colibri-imx6ull = "u-boot"
PREFERRED_PROVIDER_u-boot-default-script = "u-boot-distro-boot"
UBOOT_MAKE_TARGET:colibri-imx6ull = "u-boot.imx"
UBOOT_ENTRYPOINT:colibri-imx6ull = "0x81000000"
UBOOT_DTB_LOADADDRESS:colibri-imx6ull = "0x82100000"
UBOOT_DTBO_LOADADDRESS:colibri-imx6ull = "0x87000000"

KERNEL_DEVICETREE:append:use-nxp-bsp = " \
    imx6ull-colibri-aster.dtb \
    imx6ull-colibri-iris.dtb \
    imx6ull-colibri-iris-v2.dtb \
    imx6ull-colibri-wifi-aster.dtb \
    imx6ull-colibri-wifi-iris.dtb \
    imx6ull-colibri-wifi-iris-v2.dtb \
"

PREFERRED_PROVIDER_virtual/kernel = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:preempt-rt = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp:preempt-rt = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/dtb:use-mainline-bsp = "device-tree-overlays-mainline"
