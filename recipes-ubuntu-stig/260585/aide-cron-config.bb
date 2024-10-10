SUMMARY = "Install and configure AIDE to use the default cron script for file integrity verification"
DESCRIPTION = "This recipe installs and configures AIDE (Advanced Intrusion Detection Environment) on Ubuntu 22.04 LTS to ensure the default cron script for file integrity verification every 30 days or less is unchanged."
LICENSE = "CLOSED"

SRC_URI = "file://configure_aide_cron.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_aide_cron.sh ${D}${sysconfdir}/security/configure_aide_cron.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_aide_cron.sh"
