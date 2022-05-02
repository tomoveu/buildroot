################################################################################
#
# enact
#
################################################################################

ENACT_VERSION = master
ENACT_SITE = $(call github,EnactTrust,enact,$(ENACT_VERSION))
ENACT_INSTALL_STAGING = YES
ENACT_DEPENDENCIES = wolftpm wolfssl

ENACT_LICENSE = GPL-2.0+
ENACT_LICENSE_FILES = LICENSE
ENACT_CPE_ID_VENDOR = EnactTrust

define ENACT_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)
endef

define ENACT_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/enact $(TARGET_DIR)/usr/bin
endef

define ENACT_CONFIG_RPATH
    touch $(@D)/build-aux/config.rpath
endef
# Fix for autoconf bug with config.rconf
ENACT_PRE_CONFIGURE_HOOKS += ENACT_CONFIG_RPATH

$(eval $(generic-package))

