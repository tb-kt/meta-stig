SUMMARY = "Configure audit records for uses of ssh-agent command"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to generate audit records for successful/unsuccessful uses of the ssh-agent command."
LICENSE = "CLOSED"

SRC_URI = "file://audit_ssh_agent_command.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/audit_ssh_agent_command.sh ${D}${bindir}/audit_ssh_agent_command.sh
}

FILES_${PN} += "${bindir}/audit_ssh_agent_command.sh"

RDEPENDS_${PN} += "auditd coreutils"

# Run the script after installation to configure audit rule
pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    /bin/sh ${bindir}/audit_ssh_agent_command.sh || {
        echo "Failed to configure audit rule for ssh-agent"
        exit 1
    }
}
