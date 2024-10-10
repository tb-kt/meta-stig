SUMMARY = "Install and configure AIDE for file integrity verification with notification to designated personnel"
DESCRIPTION = "This recipe installs and configures AIDE (Advanced Intrusion Detection Environment) on Ubuntu 22.04 LTS to notify designated personnel when unauthorized changes are detected."
LICENSE = "CLOSED"

SRC_URI = "file://configure_aide_notifications.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_aide_notifications.sh ${D}${sysconfdir}/security/configure_aide_notifications.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_aide_notifications.sh"
