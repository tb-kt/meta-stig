SUMMARY = "Install vlock package to allow users to manually initiate a session lock"
DESCRIPTION = "This recipe installs the 'vlock' package to allow users to directly initiate a session lock on Ubuntu 22.04 LTS and other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

SRC_URI = "file://install_vlock.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/install_vlock.sh ${D}${bindir}/install_vlock
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/install_vlock"
