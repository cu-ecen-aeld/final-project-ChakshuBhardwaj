PV:tdx = "2.2+git${SRCPV}"
SRCBRANCH:tdx = "toradex_imx_5.4.70_2.3.0"
SRCREV:tdx = "2fa8c6349e9a1d965757d44f05a6c72687850b77"
SRCREV:use-head-next:tdx = "${AUTOREV}"
SRC_URI:tdx = "git://git.toradex.com/imx-atf.git;protocol=https;branch=${SRCBRANCH}"

EXTRA_OEMAKE:append:tdx = " \
    BUILD_STRING="${SRCBRANCH}-g${@'${SRCPV}'.replace('AUTOINC+', '')}" \
"
EXTRA_OEMAKE:append:verdin-imx8mm = " \
    IMX_BOOT_UART_BASE=0x30860000 \
"
EXTRA_OEMAKE:append:verdin-imx8mp = " \
    IMX_BOOT_UART_BASE=0x30880000 \
"
