SUMMARY = "Enforce password complexity requiring at least one numeric character"
DESCRIPTION = "This recipe enforces password complexity on Ubuntu 22.04 LTS by ensuring that at least one numeric character is required in the password."
LICENSE = "CLOSED"

SRC_URI = "file://enforce_password_complexity_numeric.sh"

DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/enforce_password_complexity_numeric.sh ${D}${sysconfdir}/enforce_password_complexity_numeric.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/enforce_password_complexity_numeric.sh"
