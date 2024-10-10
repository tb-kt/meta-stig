SUMMARY = "Audit rule for unix_update command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the unix_update command."
LICENSE = "CLOSED"

SRC_URI = "file://configure_unix_update_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_unix_update_audit.sh ${D}${bindir}/configure_unix_update_audit.sh
}

FILES_${PN} += "${bindir}/configure_unix_update_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_unix_update_audit.sh || {
        echo "Failed to configure audit rule for unix_update command"
        exit 1
    }
}
