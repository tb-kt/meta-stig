SUMMARY = "Audit rule for chown, fchown, fchownat, and lchown system calls"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for all successful/unsuccessful uses of chown, fchown, fchownat, and lchown system calls."
LICENSE = "CLOSED"

SRC_URI = "file://configure_chown_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_chown_audit.sh ${D}${bindir}/configure_chown_audit.sh
}

FILES_${PN} += "${bindir}/configure_chown_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_chown_audit.sh || {
        echo "Failed to configure audit rules for chown, fchown, fchownat, and lchown"
        exit 1
    }
}
