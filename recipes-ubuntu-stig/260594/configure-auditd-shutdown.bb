SUMMARY = "Configure auditd to shut down by default upon audit failure"
DESCRIPTION = "This recipe configures auditd to shut down by default upon audit failure in Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

SRC_URI = "file://configure_auditd_shutdown.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_auditd_shutdown.sh ${D}${bindir}/configure_auditd_shutdown.sh
}

FILES_${PN} += "${bindir}/configure_auditd_shutdown.sh"

RDEPENDS_${PN} += "auditd"

# Run the script after installation to configure auditd shutdown action
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/configure_auditd_shutdown.sh || {
        echo "Failed to configure auditd shutdown action"
        exit 1
    }
}
