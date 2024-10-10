SUMMARY = "Audit rule for usermod command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the usermod command."
LICENSE = "CLOSED"

SRC_URI = "file://configure_usermod_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_usermod_audit.sh ${D}${bindir}/configure_usermod_audit.sh
}

FILES_${PN} += "${bindir}/configure_usermod_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_usermod_audit.sh || {
        echo "Failed to configure audit rule for usermod command"
        exit 1
    }
}
