SUMMARY = "Audit rule for /etc/gshadow modifications"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/gshadow."
LICENSE = "CLOSED"

SRC_URI = "file://configure_gshadow_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_gshadow_audit.sh ${D}${bindir}/configure_gshadow_audit.sh
}

FILES_${PN} += "${bindir}/configure_gshadow_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_gshadow_audit.sh || {
        echo "Failed to configure audit rule for /etc/gshadow"
        exit 1
    }
}
