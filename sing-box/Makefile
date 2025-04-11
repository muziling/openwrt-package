include $(TOPDIR)/rules.mk

PKG_NAME:=sing-box
PKG_VERSION:=1.11.7
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=nekohasekai
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

ifeq ($(ARCH),aarch64)
	sing-box-dir_ARCH:=sing-box-$(PKG_VERSION)-linux-arm64
else ifeq ($(ARCH),arm)
	sing-box-dir_ARCH:=sing-box-$(PKG_VERSION)-linux-armv7
else ifeq ($(ARCH),i386)
	sing-box-dir_ARCH:=sing-box-$(PKG_VERSION)-linux-386
else ifeq ($(ARCH),x86_64)
	sing-box-dir_ARCH:=sing-box-$(PKG_VERSION)-linux-amd64
else
  PKG_SOURCE:=dummy
endif
sing-box_ARCH:=$(sing-box-dir_ARCH).tar.gz

define Download/sing-box
        URL:=https://github.com/SagerNet/sing-box/releases/download/v$(PKG_VERSION)/
        URL_FILE:=$(sing-box_ARCH)
        FILE:=$(sing-box_ARCH)
        HASH:=$(PKG_HASH)
endef

define Package/sing-box
	SECTION:=net
	CATEGORY:=Network
	TITLE:=The universal proxy platform (VPN)
	URL:=https://github.com/SagerNet/sing-box
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_sing-box),)
	$(call Download,sing-box)
endif
endef

define Build/Compile
endef

define Package/sing-box/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/sing-box.config $(1)/etc/config/sing-box
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/sing-box.init $(1)/etc/init.d/sing-box
	$(INSTALL_DIR) $(1)/usr/bin
	tar zxvf $(DL_DIR)/$(sing-box_ARCH) -C $(1)/usr/bin --strip-components 1 $(sing-box-dir_ARCH)/sing-box
endef

$(eval $(call BuildPackage,sing-box))
