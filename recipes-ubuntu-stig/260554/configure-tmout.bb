SUMMARY = "Automatically exit interactive command shell user sessions after 15 minutes of inactivity"
DESCRIPTION = "This recipe configures the system to automatically exit interactive command shell user sessions after 15 minutes of inactivity by setting TMOUT=900"
LICENSE = "CLOSED"

SRC_URI = "file://configure_tmout.sh"

# No specific dependencies
DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/profile.d
    install -m 0755 ${WORKDIR}/configure_tmout.sh ${D}${sysconfdir}/profile.d/99-terminal_tmout.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/profile.d/99-terminal_tmout.sh"
