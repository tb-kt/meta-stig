SUMMARY = "Audit rule for init_module and finit_module system calls"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for all successful/unsuccessful uses of the init_module and finit_module system calls."
LICENSE = "CLOSED"

SRC_URI = "file://configure_init_module_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_init_module_audit.sh ${D}${bindir}/configure_init_module_audit.sh
}

FILES_${PN} += "${bindir}/configure_init_module_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_init_module_audit.sh || {
        echo "Failed to configure audit rules for init_module and finit_module"
        exit 1
    }
}
