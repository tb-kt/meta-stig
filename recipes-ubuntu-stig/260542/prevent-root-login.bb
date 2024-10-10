SUMMARY = "Prevent Direct Root Login"
DESCRIPTION = "A recipe to prevent direct login into the root account on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the script source URI
SRC_URI = "file://prevent_root_login.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/prevent_root_login.sh ${D}${bindir}/prevent_root_login
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/prevent_root_login"
