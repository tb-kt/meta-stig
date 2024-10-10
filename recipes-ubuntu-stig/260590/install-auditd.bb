SUMMARY = "Install auditd package to ensure auditing is enabled on Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe installs and enables the auditd package to ensure that auditing of security events is active."
LICENSE = "CLOSED"

SRC_URI = "file://install_auditd.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir
