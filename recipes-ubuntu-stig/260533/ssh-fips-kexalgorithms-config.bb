SUMMARY = "Ensure SSH Server Uses Only FIPS-Validated Key Exchange Algorithms"
DESCRIPTION = "A recipe to ensure that the SSH server is configured to use only FIPS-approved key exchange algorithms on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, set, and configure SSH script source URI
SRC_URI = "file://check_set_ssh_fips_kexalgorithms.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_set_ssh_fips_kexalgorithms.sh ${D}${bindir}/check_set_ssh_fips_kexalgorithms
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_set_ssh_fips_kexalgorithms"
