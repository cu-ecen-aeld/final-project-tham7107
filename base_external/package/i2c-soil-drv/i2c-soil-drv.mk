#
# i2c-soild-drv.mk, based on aesd-char.mk
#

# a07c04c8976dbd766774b303c2f7ab858f5299a2 is skel commit on issue3 branch
# 480506cadecfc906ae8a2acafac6965553fe2fec is issue3 commit on main (merge back issue 3 branch
I2C_SOIL_DRV_VERSION = 480506cadecfc906ae8a2acafac6965553fe2fec
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
#I2C_SOIL_DRV_SITE = https://github.com/tham7107/soil-monitor.git
I2C_SOIL_DRV_SITE = git@github.com:tham7107/soil-monitor.git
I2C_SOIL_DRV_SITE_METHOD = git
I2C_SOIL_DRV_GIT_SUBMODULES = YES

# No quotes around list - won't build, silently fails
I2C_SOIL_DRV_MODULE_SUBDIRS = i2c-soil-drv

# Copy driver test script to /root on target
define I2C_SOIL_DRV_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/i2c-soil-drv/i2c-soil-drv-test.sh $(TARGET_DIR)/root
endef

$(eval $(kernel-module))
$(eval $(generic-package))
