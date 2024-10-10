SUMMARY = "Install a script that offloads audit logs weekly for Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe installs a script that offloads audit logs to external storage or network weekly."
LICENSE = "CLOSED"

SRC_URI = "file://audit_offload.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/cron.weekly
    install -m 0755 ${WORKDIR}/audit_offload.sh ${D}${sysconfdir}/cron.weekly/audit_offload
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/cron.weekly/audit_offload"
