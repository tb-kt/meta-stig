SUMMARY = "Ensure Unique User IDs for Interactive Users"
DESCRIPTION = "A recipe to ensure that all interactive users on Ubuntu 22.04 LTS have unique User IDs."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the script source URI
SRC_URI = "file://ensure_unique_user_ids.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/ensure_unique_user_ids.sh ${D}${bindir}/ensure_unique_user_ids
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/ensure_unique_user_ids"
