SUMMARY = "Enforce a delay of at least four seconds between logon prompts after a failed logon"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to enforce a delay of at least four seconds between logon prompts following a failed logon attempt using the pam_faildelay module."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

SRC_URI = "file://enforce_logon_delay.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/enforce_logon_delay.sh ${D}${bindir}/enforce_logon_delay
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/enforce_logon_delay"
