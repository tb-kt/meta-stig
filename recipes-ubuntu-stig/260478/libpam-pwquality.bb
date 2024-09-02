# File: meta-security/recipes-security/libpam-pwquality/libpam-pwquality_1.4.4.bb

DESCRIPTION = "PAM module to check password strength"
SECTION = "security"
LICENSE = "CLOSED"

SRC_URI = "http://archive.ubuntu.com/ubuntu/pool/main/libp/libpwquality/libpam-pwquality_1.4.4-1build2_amd64.deb"


DEPENDS = "dpkg"

RDEPENDS_${PN} = "dpkg"

S = "${WORKDIR}"

do_install() {
    dpkg -i ${S}/libpam-pwquality_1.4.4-1build2_amd64.deb
}

FILES_${PN} += "/usr/lib/x86_64-linux-gnu/security/pam_pwquality.so"
