SUMMARY = "Ensure System Time Zone is Configured to UTC"
DESCRIPTION = "A recipe to ensure that the system time zone is configured to use Coordinated Universal Time (UTC) on Ubuntu 22.04 LTS or other supported systems."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check and set UTC timezone script source URI
SRC_URI = "file://check_set_utc_timezone.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_set_utc_timezone.sh ${D}${bindir}/check_set_utc_timezone
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_set_utc_timezone"
