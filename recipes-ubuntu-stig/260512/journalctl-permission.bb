SUMMARY = "Check and Set Permissions for journalctl Command"
DESCRIPTION = "A recipe to ensure that the journalctl command is accessible only to authorized users by setting its permissions to '740' on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check and fix permission script source URI
SRC_URI = "file://check_fix_journalctl_permission.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_fix_journalctl_permission.sh ${D}${bindir}/check_fix_journalctl_permission
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_fix_journalctl_permission"
