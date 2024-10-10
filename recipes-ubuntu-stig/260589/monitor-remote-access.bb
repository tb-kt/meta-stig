SUMMARY = "Configure rsyslog to monitor remote access methods on Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe installs and configures rsyslog to monitor remote access methods including auth, authpriv, and daemon logs."
LICENSE = "CLOSED"

SRC_URI = "file://monitor_remote_access.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/monitor_remote_access.sh ${D}${sysconfdir}/init.d/monitor_remote_access
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/init.d/monitor_remote_access"
