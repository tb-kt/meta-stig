SUMMARY = "Configure password encryption using FIPS 140-3-approved SHA512 algorithm"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to encrypt all stored passwords with SHA512, which is compliant with FIPS 140-3 standards."
LICENSE = "CLOSED"

SRC_URI = "file://configure_password_encryption.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_password_encryption.sh ${D}${sysconfdir}/security/configure_password_encryption.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_password_encryption.sh"
