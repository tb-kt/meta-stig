SUMMARY = "Configure audit records for uses of chacl command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the chacl command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_chacl.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_chacl.sh ${D}${bindir}/audit_chacl.sh
}

FILES_${PN} += "${bindir}/audit_chacl.sh"

RDEPENDS_${PN} += "auditd acl"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_chacl.sh || {
        echo "Failed to configure audit rule for chacl"
        exit 1
    }
}
