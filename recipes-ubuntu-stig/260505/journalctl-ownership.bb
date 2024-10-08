SUMMARY = "Check and Set Ownership for the journalctl Command"
DESCRIPTION = "A recipe to ensure that the journalctl command is owned by 'root' on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check and fix ownership script source URI
SRC_URI = "file://check_fix_journalctl_ownership.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_fix_journalctl_ownership.sh ${D}${bindir}/check_fix_journalctl_ownership
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_fix_journalctl_ownership"
