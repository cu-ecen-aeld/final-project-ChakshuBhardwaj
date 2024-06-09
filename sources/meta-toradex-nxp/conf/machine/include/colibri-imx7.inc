IMAGE_CLASSES:append = " image_type_tezi"
IMAGE_FSTYPES:append = " teziimg"
TORADEX_PRODUCT_IDS = "0032 0033 0041"
TORADEX_PRODUCT_IDS[0032] = "imx7s-colibri-eval-v3.dtb"
TORADEX_PRODUCT_IDS[0033] = "imx7d-colibri-eval-v3.dtb"
TORADEX_PRODUCT_IDS[0041] = "imx7d-colibri-eval-v3.dtb"
TORADEX_FLASH_TYPE = "rawnand"

MACHINE_NAME = "Colibri-iMX7"

MACHINE_FIRMWARE:remove = "firmware-imx-epdc"
MACHINE_FIRMWARE:remove:use-mainline-bsp = "firmware-imx-vpu-imx6q firmware-imx-vpu-imx6d"

KERNEL_DEVICETREE:append:use-nxp-bsp = " \
    imx7d-colibri-iris.dtb \
    imx7d-colibri-iris-v2.dtb \
    imx7s-colibri-iris.dtb \
    imx7s-colibri-iris-v2.dtb \
"
KERNEL_DEVICETREE:append:use-mainline-bsp = " \
    imx7d-colibri-aster.dtb \
    imx7s-colibri-aster.dtb \
"

PREFERRED_PROVIDER_virtual/kernel = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:preempt-rt = "linux-toradex"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/kernel:use-mainline-bsp:preempt-rt = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/dtb:use-mainline-bsp = "device-tree-overlays-mainline"

IMX_DEFAULT_BOOTLOADER:colibri-imx7 = "u-boot"
PREFERRED_PROVIDER_u-boot-default-script = "u-boot-distro-boot"

UBOOT_MAKE_TARGET:colibri-imx7 = "u-boot.imx"
UBOOT_ENTRYPOINT:colibri-imx7 = "0x81000000"
UBOOT_DTB_LOADADDRESS:colibri-imx7 = "0x82000000"
UBOOT_DTBO_LOADADDRESS:colibri-imx7 = "0x87000000"
