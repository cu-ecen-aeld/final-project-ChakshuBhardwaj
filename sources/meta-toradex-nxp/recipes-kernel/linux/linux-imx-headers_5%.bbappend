LIC_FILES_CHKSUM:tdx = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
SRCBRANCH:tdx = "toradex_5.4-2.1.x-imx"
LOCALVERSION:tdx = "-2.3.2"
SRC_URI:tdx = "git://git.toradex.com/linux-toradex.git;protocol=https;branch=${SRCBRANCH}"
# Keep that one stable, i.e. use the exact git hash from the NXP BSP.
SRCREV:tdx = "dea2fede7e024ee7029b13e8d82a00ec14427777"
PV:tdx = "5.4"
IMX_UAPI_HEADERS:remove:tdx = "imx_vpu.h"

do_install:append:tdx() {
    # FIXME: The ion.h is still on staging so "promote" it for now
    # and install it by hand
    cp ${S}/drivers/staging/android/uapi/ion.h ${S}${includedir}/linux
    install -D -m 0644 ${S}/drivers/staging/android/uapi/ion.h \
                       ${D}${includedir}/imx/linux/ion.h

}
