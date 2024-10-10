SUMMARY = "Ensure users are required to reauthenticate for privilege escalation"
DESCRIPTION = "This recipe ensures that users must reauthenticate for privilege escalation or when changing roles on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

SRC_URI = "file://configure_sudoers_reauth.sh"

DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/configure_sudoers_reauth.sh ${D}${sysconfdir}/configure_sudoers_reauth.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/configure_sudoers_reauth.sh"
