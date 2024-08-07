#
# i2c-soild-drv.mk, based on aesd-char.mk
#

I2C_SOIL_DRV_VERSION = ac8bc3f0a5214c29cf41a2bfc2a9a6409d595635
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
