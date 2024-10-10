SUMMARY = "Install and configure AIDE to protect the integrity of audit tools"
DESCRIPTION = "This recipe installs and configures AIDE (Advanced Intrusion Detection Environment) on Ubuntu 22.04 LTS to use cryptographic mechanisms to protect the integrity of audit tools."
LICENSE = "CLOSED"

SRC_URI = "file://configure_aide_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_aide_audit.sh ${D}${sysconfdir}/security/configure_aide_audit.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_aide_audit.sh"
