SUMMARY = "Enforce encrypted password storage on Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe ensures that passwords are stored in an encrypted form using SHA-512, following the STIG requirements."
LICENSE = "CLOSED"

SRC_URI = "file://encrypt_passwords.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/pam.d
    install -m 0755 ${WORKDIR}/encrypt_passwords.sh ${D}${sysconfdir}/pam.d/encrypt_passwords.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/pam.d/encrypt_passwords.sh"
