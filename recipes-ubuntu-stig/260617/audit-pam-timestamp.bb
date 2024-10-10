SUMMARY = "Configure audit records for uses of pam_timestamp_check command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the pam_timestamp_check command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_pam_timestamp_check.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_pam_timestamp_check.sh ${D}${bindir}/audit_pam_timestamp_check.sh
}

FILES_${PN} += "${bindir}/audit_pam_timestamp_check.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_pam_timestamp_check.sh || {
        echo "Failed to configure audit rule for pam_timestamp_check"
        exit 1
    }
}
