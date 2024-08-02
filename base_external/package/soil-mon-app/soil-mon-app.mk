#
# soil-mon-app.mk, based on aesd-char.mk
#

SOIL_MON_APP_VERSION = f3e0d6096e6df989adb6cbef251e91b69801938d
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
#
# Despite this warning above ^^^ I changed back to the https to allow
# graders to easily build the system without needing to load GitHub
# keys. Using SSH for the repo URL requires a GitHub SSH key, https
# does not. Not using the automated build/test for ECEA5307.
#
SOIL_MON_APP_SITE = https://github.com/tham7107/soil-monitor.git
SOIL_MON_APP_SITE_METHOD = git
SOIL_MON_APP_GIT_SUBMODULES = YES

# No quotes around list - won't build, silently fails
SOIL_MON_APP_MODULE_SUBDIRS = soil-monitor

# Copy driver test script to /root on target
define SOIL_MON_APP_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/soil-mon-app/pump-control.sh $(TARGET_DIR)/root
endef

$(eval $(generic-package))
