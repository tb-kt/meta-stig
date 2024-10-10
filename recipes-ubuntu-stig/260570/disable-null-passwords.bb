SUMMARY = "Ensure no accounts are allowed to have blank or null passwords on Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe ensures that no accounts can have null passwords by modifying the common-password PAM configuration to remove any instances of the 'nullok' option."
LICENSE = "CLOSED"

SRC_URI = "file://disable_null_passwords.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/pam.d
    install -m 0755 ${WORKDIR}/disable_null_passwords.sh ${D}${sysconfdir}/pam.d/disable_null_passwords.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/pam.d/disable_null_passwords.sh"
