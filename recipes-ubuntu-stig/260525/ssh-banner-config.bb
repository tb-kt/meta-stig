SUMMARY = "Ensure SSH Banner Displays Standard Mandatory DOD Notice and Consent Banner"
DESCRIPTION = "A recipe to ensure the SSH banner displays the standard mandatory DOD notice and consent banner before granting access to the system on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, set, and enable SSH banner script source URI
SRC_URI = "file://check_set_ssh_banner.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_set_ssh_banner.sh ${D}${bindir}/check_set_ssh_banner
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_set_ssh_banner"
