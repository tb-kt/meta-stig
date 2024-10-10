SUMMARY = "Configure auditd to alert the ISSO and SA in the event of an audit processing failure"
DESCRIPTION = "This recipe installs the required email package and configures auditd to send alerts in case of audit processing failures."
LICENSE = "CLOSED"

SRC_URI = "file://configure_auditd_alert.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_auditd_alert.sh ${D}${bindir}/configure_auditd_alert.sh
}

FILES_${PN} += "${bindir}/configure_auditd_alert.sh"

RDEPENDS_${PN} += "mailx"

# Run the script after installation to configure auditd alerts
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/configure_auditd_alert.sh || {
        echo "Failed to configure auditd alert"
        exit 1
    }
}
