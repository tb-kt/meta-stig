SUMMARY = "Configure audit records for uses of setfacl command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the setfacl command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_setfacl_command.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_setfacl_command.sh ${D}${bindir}/audit_setfacl_command.sh
}

FILES_${PN} += "${bindir}/audit_setfacl_command.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_setfacl_command.sh || {
        echo "Failed to configure audit rule for setfacl"
        exit 1
    }
}
