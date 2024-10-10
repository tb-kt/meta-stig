SUMMARY = "Configure audit records for uses of chfn command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the chfn command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_chfn.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_chfn.sh ${D}${bindir}/audit_chfn.sh
}

FILES_${PN} += "${bindir}/audit_chfn.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_chfn.sh || {
        echo "Failed to configure audit rule for chfn"
        exit 1
    }
}
