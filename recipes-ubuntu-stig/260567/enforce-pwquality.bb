SUMMARY = "Enforce pwquality usage for password complexity on Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe enforces the use of pwquality for password complexity, ensuring secure password policies on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

SRC_URI = "file://enforce_pwquality.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/enforce_pwquality.sh ${D}${sysconfdir}/security/enforce_pwquality.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/enforce_pwquality.sh"
