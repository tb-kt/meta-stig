SUMMARY = "Disable Account Identifiers after 35 Days of Inactivity"
DESCRIPTION = "A recipe to configure Ubuntu 22.04 LTS to disable account identifiers (users, groups, roles, devices) after 35 days of inactivity."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the script source URI
SRC_URI = "file://disable_account_inactive.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/disable_account_inactive.sh ${D}${bindir}/disable_account_inactive
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/disable_account_inactive"
