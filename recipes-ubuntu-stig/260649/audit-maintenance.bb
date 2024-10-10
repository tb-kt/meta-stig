SUMMARY = "Audit rule for privileged activities and nonlocal maintenance sessions"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for privileged activities, nonlocal maintenance, diagnostic sessions, and other system-level access."
LICENSE = "CLOSED"

SRC_URI = "file://configure_audit_maintenance.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_audit_maintenance.sh ${D}${bindir}/configure_audit_maintenance.sh
}

FILES_${PN} += "${bindir}/configure_audit_maintenance.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_audit_maintenance.sh || {
        echo "Failed to configure audit rule for maintenance activities"
        exit 1
    }
}
