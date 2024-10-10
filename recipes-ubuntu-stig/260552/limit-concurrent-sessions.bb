SUMMARY = "Limit the number of concurrent sessions to 10 for all accounts"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to limit the number of concurrent sessions to 10 for all accounts and/or account types."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

SRC_URI = "file://limit_concurrent_sessions.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/limit_concurrent_sessions.sh ${D}${bindir}/limit_concurrent_sessions
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/limit_concurrent_sessions"
