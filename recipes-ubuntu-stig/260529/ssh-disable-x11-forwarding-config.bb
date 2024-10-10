SUMMARY = "Ensure SSH X11 Forwarding is Disabled"
DESCRIPTION = "A recipe to ensure that SSH X11 forwarding is disabled on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, set, and configure SSH script source URI
SRC_URI = "file://check_set_ssh_disable_x11_forwarding.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_set_ssh_disable_x11_forwarding.sh ${D}${bindir}/check_set_ssh_disable_x11_forwarding
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_set_ssh_disable_x11_forwarding"
