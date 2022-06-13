################################################################################
#
# enact
#
################################################################################

ENACT_VERSION = master
ENACT_SITE = $(call github,EnactTrust,enact,$(ENACT_VERSION))
ENACT_INSTALL_STAGING = YES
ENACT_DEPENDENCIES = wolftpm wolfssl libcurl
ENACT_LICENSE = GPL-2.0+
ENACT_LICENSE_FILES = LICENSE
ENACT_CPE_ID_VENDOR = EnactTrust

define ENACT_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)
endef

define ENACT_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/enact $(TARGET_DIR)/usr/bin
endef

# Fix for missing config.rpath in the codebase
define ENACT_TOUCH_CONFIG_RPATH
    mkdir -p $(@D)/build-aux
    touch $(@D)/build-aux/config.rpath
endef
ENACT_PRE_CONFIGURE_HOOKS += ENACT_TOUCH_CONFIG_RPATH

ifeq ($(BR2_PACKAGE_ENACT_TPM_GPIO),y)
ENACT_CONF_OPTS += -DENACT_TPM_GPIO_ENABLE
endif

$(eval $(generic-package))

