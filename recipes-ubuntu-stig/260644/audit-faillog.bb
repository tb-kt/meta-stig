SUMMARY = "Audit rule for /var/log/faillog file"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for all modifications that affect the /var/log/faillog file."
LICENSE = "CLOSED"

SRC_URI = "file://configure_faillog_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_faillog_audit.sh ${D}${bindir}/configure_faillog_audit.sh
}

FILES_${PN} += "${bindir}/configure_faillog_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_faillog_audit.sh || {
        echo "Failed to configure audit rule for /var/log/faillog"
        exit 1
    }
}
