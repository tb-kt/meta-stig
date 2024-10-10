SUMMARY = "Configure pam_faillock to lock an account after three failed login attempts"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to automatically lock an account after three unsuccessful logon attempts using the pam_faillock module."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

SRC_URI = "file://pam_faillock_setup.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/pam_faillock_setup.sh ${D}${bindir}/pam_faillock_setup
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/pam_faillock_setup"
