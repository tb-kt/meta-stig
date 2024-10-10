SUMMARY = "Ensure Maximum Password Lifetime of 60 Days for New Users"
DESCRIPTION = "A recipe to ensure that Ubuntu 22.04 LTS enforces a 60-day maximum password lifetime for new user accounts."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the script source URI
SRC_URI = "file://enforce_max_password_lifetime.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/enforce_max_password_lifetime.sh ${D}${bindir}/enforce_max_password_lifetime
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/enforce_max_password_lifetime"
