SUMMARY = "Ensure SSH is Installed, Enabled, and Running"
DESCRIPTION = "A recipe to ensure that SSH (Secure Shell) is installed, enabled, and running on Ubuntu 22.04 LTS or other supported systems to protect transmitted information and support secure access."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, install, and enable SSH script source URI
SRC_URI = "file://check_install_enable_ssh.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_install_enable_ssh.sh ${D}${bindir}/check_install_enable_ssh
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_install_enable_ssh"
