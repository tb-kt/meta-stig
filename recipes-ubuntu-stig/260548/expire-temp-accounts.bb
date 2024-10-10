SUMMARY = "Expire Temporary Accounts After 72 Hours"
DESCRIPTION = "A recipe to configure Ubuntu 22.04 LTS to automatically expire temporary accounts within 72 hours."

LICENSE = "CLOSED"
# No specific dependencies
DEPENDS = ""

SRC_URI = "file://expire_temp_accounts.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/expire_temp_accounts.sh ${D}${bindir}/expire_temp_accounts
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/expire_temp_accounts"
