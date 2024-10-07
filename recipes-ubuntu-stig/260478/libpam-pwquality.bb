SUMMARY = "Check and Install libpam-pwquality"
DESCRIPTION = "A recipe to ensure that libpam-pwquality is installed on Ubuntu 22.04 LTS"
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check and install script
SRC_URI = "file://check_install_libpam_pwquality.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_install_libpam_pwquality.sh ${D}${bindir}/check_install_libpam_pwquality
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_install_libpam_pwquality"
