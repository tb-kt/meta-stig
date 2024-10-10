SUMMARY = "Audit rule for /etc/shadow modifications"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/shadow."
LICENSE = "CLOSED"

SRC_URI = "file://configure_shadow_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_shadow_audit.sh ${D}${bindir}/configure_shadow_audit.sh
}

FILES_${PN} += "${bindir}/configure_shadow_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_shadow_audit.sh || {
        echo "Failed to configure audit rule for /etc/shadow"
        exit 1
    }
}
