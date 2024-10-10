SUMMARY = "Enforce password complexity requiring at least one special character"
DESCRIPTION = "This recipe enforces password complexity on Ubuntu 22.04 LTS by ensuring that at least one special character is required in the password."
LICENSE = "CLOSED"

SRC_URI = "file://enforce_password_complexity_special.sh"

DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/enforce_password_complexity_special.sh ${D}${sysconfdir}/enforce_password_complexity_special.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/enforce_password_complexity_special.sh"
