INTEL_COMMON_PACKAGE_ARCH ?= "${TUNE_PKGARCH}-intel-common"
PACKAGE_ARCH:pn-linux-intel = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-linux-intel-rt = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-linux-intel-tiny = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-linux-intel-dev = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-linux-yocto = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-linux-yocto-rt = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-linux-yocto-tiny = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-linux-yocto-dev = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-intel-microcode = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-backport-iwlwifi = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-ixgbe = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_ARCH:pn-ixgbevf = "${INTEL_COMMON_PACKAGE_ARCH}"
PACKAGE_EXTRA_ARCHS:append = " ${INTEL_COMMON_PACKAGE_ARCH}"
MACHINEOVERRIDES =. "${INTEL_COMMON_PACKAGE_ARCH}:"