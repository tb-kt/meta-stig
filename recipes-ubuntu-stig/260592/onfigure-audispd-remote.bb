SUMMARY = "Configure auditd event multiplexor to offload audit logs to a remote server"
DESCRIPTION = "This recipe installs the audispd-plugins and configures audit logs to be offloaded to a remote server."
LICENSE = "CLOSED"

SRC_URI = "file://configure_audispd_remote.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_audispd_remote.sh ${D}${bindir}/configure_audispd_remote.sh
}

FILES_${PN} += "${bindir}/configure_audispd_remote.sh"

RDEPENDS_${PN} += "audispd-plugins"

# Run the script after installation to configure audisp-remote
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/configure_audispd_remote.sh || {
        echo "Failed to configure audisp-remote for auditd"
        exit 1
    }
}
