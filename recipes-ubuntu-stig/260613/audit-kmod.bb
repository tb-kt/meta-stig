SUMMARY = "Configure audit records for uses of kmod command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the kmod command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_kmod.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_kmod.sh ${D}${bindir}/audit_kmod.sh
}

FILES_${PN} += "${bindir}/audit_kmod.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_kmod.sh || {
        echo "Failed to configure audit rule for kmod"
        exit 1
    }
}
