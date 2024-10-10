SUMMARY = "Configure audit records for uses of apparmor_parser command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the apparmor_parser command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_apparmor_parser.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_apparmor_parser.sh ${D}${bindir}/audit_apparmor_parser.sh
}

FILES_${PN} += "${bindir}/audit_apparmor_parser.sh"

RDEPENDS_${PN} += "auditd apparmor"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_apparmor_parser.sh || {
        echo "Failed to configure audit rule for apparmor_parser"
        exit 1
    }
}
