SUMMARY = "Check and Set Permissions for System Log Files"
DESCRIPTION = "A recipe to ensure that system log files have mode 640 or less permissive on Ubuntu 22.04 LTS, excluding btmp, wtmp, and lastlog."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check and fix permissions script source URI
SRC_URI = "file://check_fix_log_file_permissions.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_fix_log_file_permissions.sh ${D}${bindir}/check_fix_log_file_permissions
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_fix_log_file_permissions"
