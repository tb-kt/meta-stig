SUMMARY = "Ensure Uncomplicated Firewall (ufw) is Configured to Restrict Unnecessary Ports and Protocols"
DESCRIPTION = "A recipe to ensure that the Uncomplicated Firewall (ufw) is installed, configured, and used to restrict the use of unnecessary ports, protocols, and services on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, install, configure, and restrict ufw script source URI
SRC_URI = "file://check_install_configure_ufw.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_install_configure_ufw.sh ${D}${bindir}/check_install_configure_ufw
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_install_configure_ufw"
