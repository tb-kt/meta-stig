SUMMARY = "Configure auditd to notify SA and ISSO at 25% storage volume capacity"
DESCRIPTION = "This recipe configures auditd to notify the system administrator (SA) and information system security officer (ISSO) when audit record storage volume reaches 25% remaining of allocated capacity on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

SRC_URI = "file://configure_audit_notification.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_audit_notification.sh ${D}${bindir}/configure_audit_notification.sh
}

FILES_${PN} += "${bindir}/configure_audit_notification.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to configure audit notification
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/configure_audit_notification.sh || {
        echo "Failed to configure audit notification"
        exit 1
    }
}
