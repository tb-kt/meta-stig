SUMMARY = "Audit rule for /etc/passwd modifications"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/passwd."
LICENSE = "CLOSED"

SRC_URI = "file://configure_passwd_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_passwd_audit.sh ${D}${bindir}/configure_passwd_audit.sh
}

FILES_${PN} += "${bindir}/configure_passwd_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_passwd_audit.sh || {
        echo "Failed to configure audit rule for /etc/passwd"
        exit 1
    }
}
