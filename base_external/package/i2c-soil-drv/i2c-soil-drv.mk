#
# i2c-soild-drv.mk, based on aesd-char.mk
#

# 8ad8a2dc881e1b06d1366d0e4ff675d362f8ea3f is issue4 commit on main (merge back issue 4 branch)
I2C_SOIL_DRV_VERSION = 233300d9804554c487b026082f350c21d267a190
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
#
# Despite this warning above ^^^ I changed back to the https to allow
# graders to easily build the system without needing to load GitHub
# keys. Using SSH for the repo URL requires a GitHub SSH key, https
# does not. Not using the automated build/test for ECEA5307.
#
I2C_SOIL_DRV_SITE = https://github.com/tham7107/soil-monitor.git
I2C_SOIL_DRV_SITE_METHOD = git
I2C_SOIL_DRV_GIT_SUBMODULES = YES

# No quotes around list - won't build, silently fails
I2C_SOIL_DRV_MODULE_SUBDIRS = i2c-soil-drv

# Copy driver test script to /root on target
define I2C_SOIL_DRV_INSTALL_TARGET_CMDS
    $(INSTALL) -m 0755 $(@D)/i2c-soil-drv/i2c-soil-drv-test.sh $(TARGET_DIR)/root
endef

$(eval $(kernel-module))
$(eval $(generic-package))
