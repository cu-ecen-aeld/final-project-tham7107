
##############################################################
#
# AESD-CHAR
#
##############################################################

# a07c04c8976dbd766774b303c2f7ab858f5299a2 is skel commit on issue3 branch
I2C_SOIL_DRV_VERSION = a07c04c8976dbd766774b303c2f7ab858f5299a2
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
I2C_SOIL_DRV_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-tham7107.git
I2C_SOIL_DRV_SITE_METHOD = git
I2C_SOIL_DRV_GIT_SUBMODULES = YES

#I2C_SOIL_DRV_VERSION = 1.0
#I2C_SOIL_DRV_SITE = $(BR2_EXTERNAL_SOIL_DRIVER_PATH)
#I2C_SOIL_DRV_SITE_METHOD = local

# No quotes around list - won't build, silently fails
I2C_SOIL_DRV_MODULE_SUBDIRS = i2c-soil-drv

$(eval $(kernel-module))
$(eval $(generic-package))
