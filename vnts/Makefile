include $(TOPDIR)/rules.mk

PKG_NAME:=vnts
PKG_VERSION:=1.2.8.1
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=lbl8603
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

ifeq ($(ARCH),aarch64)
	vnts_ARCH:=vnts-aarch64-unknown-linux-musl-$(PKG_VERSION).tar.gz
else ifeq ($(ARCH),arm)
	vnts_ARCH:=vnts-armv7-unknown-linux-musleabihf-$(PKG_VERSION).tar.gz
else ifeq ($(ARCH),i386)
	vnts_ARCH:=vnts-i686-unknown-linux-musl-$(PKG_VERSION).tar.gz
else ifeq ($(ARCH),x86_64)
	vnts_ARCH:=vnts-x86_64-unknown-linux-musl-$(PKG_VERSION).tar.gz
else
  PKG_SOURCE:=dummy
endif

define Download/vnts
        URL:=https://github.com/muziling/vnts/releases/download/$(PKG_VERSION)/
        URL_FILE:=$(vnts_ARCH)
        FILE:=$(vnts_ARCH)
        HASH:=$(PKG_HASH)
endef

define Package/vnts
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A virtual network tool server(VPN)
	DEPENDS:=+kmod-tun
	URL:=https://github.com/lbl8603/vnts
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_vnts),)
	$(call Download,vnts)
endif
endef

define Build/Compile
endef

define Package/vnts/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/vnts.config $(1)/etc/config/vnts
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/vnts.init $(1)/etc/init.d/vnts
	$(INSTALL_DIR) $(1)/etc/vnts/
	$(INSTALL_DIR) $(1)/usr/bin
	tar zxvf $(DL_DIR)/$(vnts_ARCH) -C $(1)/usr/bin
endef

$(eval $(call BuildPackage,vnts))
