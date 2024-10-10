SUMMARY = "Enable auditd service to ensure audit records are generated in near real-time for all DoD-defined auditable events"
DESCRIPTION = "This recipe installs and enables the auditd service to ensure that audit records contain sufficient information for investigation and forensic purposes."
LICENSE = "CLOSED"

SRC_URI = "file://enable_auditd.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/enable_auditd.sh ${D}${bindir}/enable_auditd.sh
}

FILES_${PN} += "${bindir}/enable_auditd.sh"

RDEPENDS_${PN} += "audit"

# Run the script after installation to enable and start auditd
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/enable_auditd.sh || {
        echo "Failed to enable auditd service"
        exit 1
    }
}
