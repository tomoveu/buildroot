################################################################################
#
# wolftpm
#
################################################################################

WOLFTPM_VERSION = 2.3.1
WOLFTPM_SITE = $(call github,wolfSSL,wolfTPM,v$(WOLFTPM_VERSION))
WOLFTPM_INSTALL_STAGING = YES
WOLFTPM_LICENSE = GPL-2.0+
WOLFTPM_LICENSE_FILES = LICENSE
WOLFTPM_CPE_ID_VENDOR = wolfssl
WOLFTPM_DEPENDENCIES = host-pkgconf
WOLFTPM_CONFIG_SCRIPTS = wolftpm-config

# wolfTPM's source code is released without a configure script,
# therefore we need autoreconf
WOLFTPM_AUTORECONF = YES

WOLFTPM_CONF_OPTS = \
	--disable-examples \
	--enable-devtpm \
	--with-wolfcrypt=$(STAGING_DIR)/usr

# Fix for missing config.rpath in the codebase
define WOLFTPM_TOUCH_CONFIG_RPATH
	mkdir -p $(@D)/build-aux
	touch $(@D)/build-aux/config.rpath
endef
WOLFTPM_PRE_CONFIGURE_HOOKS += WOLFTPM_TOUCH_CONFIG_RPATH

ifeq ($(BR2_PACKAGE_WOLFTPM_ST33),y)
WOLFTPM_CONF_OPTS += --enable-st33
else
WOLFTPM_CONF_OPTS += --disable-st33
endif

$(eval $(autotools-package))
