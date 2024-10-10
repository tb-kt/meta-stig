SUMMARY = "Enforce a minimum 15-character password length"
DESCRIPTION = "This recipe enforces password complexity on Ubuntu 22.04 LTS by ensuring that passwords must have at least 15 characters."
LICENSE = "CLOSED"

SRC_URI = "file://enforce_min_password_length.sh"

DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/enforce_min_password_length.sh ${D}${sysconfdir}/enforce_min_password_length.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/enforce_min_password_length.sh"
