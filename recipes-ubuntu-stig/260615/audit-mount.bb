SUMMARY = "Configure audit records for uses of mount command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the mount command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_mount.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_mount.sh ${D}${bindir}/audit_mount.sh
}

FILES_${PN} += "${bindir}/audit_mount.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_mount.sh || {
        echo "Failed to configure audit rule for mount"
        exit 1
    }
}
