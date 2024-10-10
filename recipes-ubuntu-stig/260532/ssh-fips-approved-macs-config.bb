SUMMARY = "Ensure SSH Daemon Uses FIPS 140-3 Approved MACs"
DESCRIPTION = "A recipe to ensure that the SSH daemon is configured to use FIPS-approved MACs on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, set, and configure SSH script source URI
SRC_URI = "file://check_set_ssh_fips_macs.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_set_ssh_fips_macs.sh ${D}${bindir}/check_set_ssh_fips_macs
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_set_ssh_fips_macs"
