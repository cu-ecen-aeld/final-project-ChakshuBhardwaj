# Create symbolic link rather than copying mkimage_uboot
compile_mx8m:prepend() {
    rm -rf ${BOOT_STAGING}/mkimage_uboot
#    export LD_LIBRARY_PATH=${STAGING_LIBDIR_NATIVE}:$LD_LIBRARY_PATH
}
compile_mx8m:append() {
    rm -rf ${BOOT_STAGING}/mkimage_uboot
    ln -frs ${STAGING_DIR_NATIVE}/${bindir}/mkimage ${BOOT_STAGING}/mkimage_uboot
}
