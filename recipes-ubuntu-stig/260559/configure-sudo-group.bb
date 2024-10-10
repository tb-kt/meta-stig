SUMMARY = "Ensure only authorized users are part of the sudo group"
DESCRIPTION = "This recipe ensures only users who need access to security functions are part of the sudo group on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

SRC_URI = "file://configure_sudo_group.sh"

DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/configure_sudo_group.sh ${D}${sysconfdir}/configure_sudo_group.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/configure_sudo_group.sh"
