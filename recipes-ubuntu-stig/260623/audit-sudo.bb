SUMMARY = "Audit rule for sudo command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the sudo command."
LICENSE = "CLOSED"

SRC_URI = "file://configure_sudo_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_sudo_audit.sh ${D}${bindir}/configure_sudo_audit.sh
}

FILES_${PN} += "${bindir}/configure_sudo_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_sudo_audit.sh || {
        echo "Failed to configure audit rule for sudo command"
        exit 1
    }
}
