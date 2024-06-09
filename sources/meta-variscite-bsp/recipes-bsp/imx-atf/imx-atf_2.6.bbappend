FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:mx8-nxp-bsp = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH} \
           file://0001-Makefile-Suppress-array-bounds-error.patch \
           file://rwx-segments.patch \
"
SRCBRANCH:mx8-nxp-bsp = "lf_v2.6_var01"
SRCREV:mx8-nxp-bsp = "b0039c73c070f0f1a6455c6c0d828310f12f0e8d"

SRC_URI:imx93-var-som = "git://github.com/varigit/imx-atf;protocol=https;branch=${SRCBRANCH}"
SRCBRANCH:imx93-var-som = "lf_v2.6_var02"
SRCREV:imx93-var-som = "d8bc791fb5fc4a6277c12a696961d4f3f2fee52b"

EXTRA_OEMAKE:append:imx8mq-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"

EXTRA_OEMAKE:append:imx8mm-var-dart = " \
    BL32_BASE=${TEE_LOAD_ADDR} \
"
