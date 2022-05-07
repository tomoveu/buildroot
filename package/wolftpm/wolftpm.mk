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

# wolfTPM's source code is released without a configure script,
# therefore we need autoreconf
WOLFTPM_AUTORECONF = YES

WOLFTPM_CONF_OPTS = --disable-examples --enable-devtpm --with-wolfcrypt=$(TARGET_DIR)/usr/

define WOLFTPM_CONFIG_RPATH
    touch $(@D)/build-aux/config.rpath
endef
# Fix for autoconf bug with config.rconf
WOLFTPM_PRE_CONFIGURE_HOOKS += WOLFTPM_CONFIG_RPATH

$(eval $(autotools-package))
