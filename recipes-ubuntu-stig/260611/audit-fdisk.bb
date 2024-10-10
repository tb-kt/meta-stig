SUMMARY = "Configure audit records for uses of fdisk command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the fdisk command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_fdisk.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_fdisk.sh ${D}${bindir}/audit_fdisk.sh
}

FILES_${PN} += "${bindir}/audit_fdisk.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_fdisk.sh || {
        echo "Failed to configure audit rule for fdisk"
        exit 1
    }
}
