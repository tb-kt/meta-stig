SUMMARY = "Check and Remove telnetd package"
DESCRIPTION = "A recipe to ensure that the telnetd package is not installed on Ubuntu 22.04 LTS or RHEL-based systems"
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check and remove script source URI
SRC_URI = "file://check_remove_telnetd.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_remove_telnetd.sh ${D}${bindir}/check_remove_telnetd
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_remove_telnetd"
