SUMMARY = "Ensure no accounts are configured with blank or null passwords on Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe checks for accounts with null passwords and locks them to ensure compliance with security guidelines."
LICENSE = "CLOSED"

SRC_URI = "file://check_null_passwords.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/check_null_passwords.sh ${D}${sysconfdir}/security/check_null_passwords.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/check_null_passwords.sh"
