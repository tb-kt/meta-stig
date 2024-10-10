SUMMARY = "Configure system to display last successful login upon logon"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to display the date and time of the last successful account logon upon logon using the pam_lastlog module."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

SRC_URI = "file://display_last_login.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/display_last_login.sh ${D}${bindir}/display_last_login
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/display_last_login"
