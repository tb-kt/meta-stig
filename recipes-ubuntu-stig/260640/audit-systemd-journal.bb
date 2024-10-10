SUMMARY = "Audit rule for systemd journal files"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for all events that affect the systemd journal files."
LICENSE = "CLOSED"

SRC_URI = "file://configure_systemd_journal_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_systemd_journal_audit.sh ${D}${bindir}/configure_systemd_journal_audit.sh
}

FILES_${PN} += "${bindir}/configure_systemd_journal_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_systemd_journal_audit.sh || {
        echo "Failed to configure audit rule for systemd journal files"
        exit 1
    }
}
