SUMMARY = "Configure audit records for uses of modprobe command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the modprobe command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_modprobe.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_modprobe.sh ${D}${bindir}/audit_modprobe.sh
}

FILES_${PN} += "${bindir}/audit_modprobe.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_modprobe.sh || {
        echo "Failed to configure audit rule for modprobe"
        exit 1
    }
}
