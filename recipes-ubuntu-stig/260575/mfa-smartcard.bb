SUMMARY = "Configure smart card logins for multifactor authentication"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to use smart card logins with pam_pkcs11 for multifactor authentication for privileged and nonprivileged accounts."
LICENSE = "CLOSED"

SRC_URI = "file://implement_mfa_smartcard.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/implement_mfa_smartcard.sh ${D}${sysconfdir}/security/implement_mfa_smartcard.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/implement_mfa_smartcard.sh"
