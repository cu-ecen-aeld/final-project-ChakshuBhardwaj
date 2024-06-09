FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}-${PV}:"
require recipes-kernel/linux/linux-imx.inc

SUMMARY = "Linux kernel for Toradex Freescale i.MX based modules"
SUMMARY:preempt-rt = "Real-Time Linux kernel for Toradex Freescale i.MX based modules"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = " \
    git://git.toradex.com/linux-toradex.git;protocol=https;branch=${SRCBRANCH};name=machine \
"

# Load USB functions configurable through configfs (CONFIG_USB_CONFIGFS)
KERNEL_MODULE_AUTOLOAD += "${@bb.utils.contains('COMBINED_FEATURES', 'usbgadget', ' libcomposite', '',d)}"

inherit toradex-kernel-localversion
LINUX_VERSION = "5.4.193"
# skip, as with use-head-next LINUX_VERSION might be set wrongly
KERNEL_VERSION_SANITY_SKIP:use-head-next = "1"

# Make sure to override LOCALVERSION in linux-imx.inc
LOCALVERSION = "-${TDX_VERSION}"

SRCBRANCH = "toradex_5.4-2.3.x-imx"
SRCREV_machine = "5a24da287b86482b0d13352d3a12fa16c81a03f0"
SRCREV_machine:use-head-next = "${AUTOREV}"

DEPENDS += "lzop-native bc-native"
COMPATIBLE_MACHINE = "(mx6-nxp-bsp|mx7-nxp-bsp|mx8-nxp-bsp)"

KBUILD_DEFCONFIG:apalis-imx6 ?= "apalis_imx6_defconfig"
KBUILD_DEFCONFIG:colibri-imx6 ?= "colibri_imx6_defconfig"
KBUILD_DEFCONFIG:colibri-imx6ull ?= "colibri-imx6ull_defconfig"
KBUILD_DEFCONFIG:colibri-imx6ull-emmc ?= "colibri-imx6ull_defconfig"
KBUILD_DEFCONFIG:mx7-nxp-bsp ?= "colibri_imx7_defconfig"
KBUILD_DEFCONFIG:mx8-nxp-bsp ?= "toradex_defconfig"

export DTC_FLAGS = "-@"

###############################################################################
# Apply the RT patch and change the configuration to use PREMPT_RT when the
# preempt-rt override is set.
###############################################################################

# patches get moved into the 'older' directory when superseeded, so provide
# both possible storage locations.
MIRRORS:append:preempt-rt = "${KERNELORG_MIRROR}/linux/kernel/projects/rt/5.4/older/ ${KERNELORG_MIRROR}/linux/kernel/projects/rt/5.4/"
SRC_URI:append:preempt-rt = " \
    ${KERNELORG_MIRROR}/linux/kernel/projects/rt/5.4/older/patch-5.4.193-rt74.patch.xz;name=rt-patch \
    file://preempt-rt.scc \
    file://preempt-rt-less-latency.scc \
"
# This patches do currently not apply but are likely needed or we get
# runtime bugs.
#    file://0001-imx_sc_thermal-prevent-BUG-with-rt-patch.patch \
#    file://0002-ddr-perf-prevent-BUG-with-rt-patch.patch \
#

SRC_URI[rt-patch.sha256sum] = "821d7bf3015d90e86eace5869d5596eacc9e4b5bd80644d40207817c4b8cc4be"
