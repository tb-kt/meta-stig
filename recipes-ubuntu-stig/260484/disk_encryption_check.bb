SUMMARY = "Check if all system partitions are encrypted"
DESCRIPTION = "A recipe to ensure that all persistent disk partitions are encrypted on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check encryption script source URI
SRC_URI = "file://check_encryption_status.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_encryption_status.sh ${D}${bindir}/check_encryption_status
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_encryption_status"
