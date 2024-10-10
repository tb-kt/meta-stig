SUMMARY = "Install and configure AIDE for file integrity verification"
DESCRIPTION = "This recipe installs and configures AIDE (Advanced Intrusion Detection Environment) on Ubuntu 22.04 LTS to verify the correct operation of all security functions."
LICENSE = "CLOSED"

SRC_URI = "file://configure_aide.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_aide.sh ${D}${sysconfdir}/security/configure_aide.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_aide.sh"
