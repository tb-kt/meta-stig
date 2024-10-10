SUMMARY = "Install and enable rsyslog to preserve log records for Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe installs and configures rsyslog to preserve log records in the case of failure events."
LICENSE = "CLOSED"

SRC_URI = "file://preserve_logs.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/preserve_logs.sh ${D}${sysconfdir}/init.d/preserve_logs
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/init.d/preserve_logs"
