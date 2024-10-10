SUMMARY = "Prevent the use of dictionary words for passwords"
DESCRIPTION = "This recipe enforces password complexity on Ubuntu 22.04 LTS by ensuring that passwords cannot be dictionary words."
LICENSE = "CLOSED"

SRC_URI = "file://prevent_dictionary_passwords.sh"

DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/prevent_dictionary_passwords.sh ${D}${sysconfdir}/prevent_dictionary_passwords.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/prevent_dictionary_passwords.sh"
