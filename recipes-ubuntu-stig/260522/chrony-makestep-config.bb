SUMMARY = "Ensure System Clock Synchronization with Authoritative Time Source with One-Second Step"
DESCRIPTION = "A recipe to ensure that the system clock is configured to synchronize with an authoritative time source when the time difference exceeds one second on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, install, and configure chrony script source URI
SRC_URI = "file://check_install_configure_chrony_makestep.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_install_configure_chrony_makestep.sh ${D}${bindir}/check_install_configure_chrony_makestep
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_install_configure_chrony_makestep"
