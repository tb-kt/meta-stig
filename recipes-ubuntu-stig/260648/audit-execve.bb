SUMMARY = "Audit rule for privileged execution using execve system call"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to prevent software from executing at higher privilege levels and audits the execution of privileged functions by adding audit rules for the execve system call."
LICENSE = "CLOSED"

SRC_URI = "file://configure_execve_audit.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_execve_audit.sh ${D}${bindir}/configure_execve_audit.sh
}

FILES_${PN} += "${bindir}/configure_execve_audit.sh"

RDEPENDS_${PN} += "auditd coreutils"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure audit rule
    /bin/sh ${bindir}/configure_execve_audit.sh || {
        echo "Failed to configure audit rule for execve"
        exit 1
    }
}
