include $(TOPDIR)/rules.mk

PKG_NAME:=vnts2
PKG_VERSION:=v2.0.6
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=lbl8603
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk
ifeq ($(ARCH),aarch64)
	vnts2_ARCH:=vnts2-aarch64-unknown-linux-musl-$(PKG_VERSION)
else ifeq ($(ARCH),arm)
	vnts2_ARCH:=vnts2-armv7-unknown-linux-musleabihf-$(PKG_VERSION)
else ifeq ($(ARCH),x86_64)
	vnts2_ARCH:=vnts2-x86_64-unknown-linux-musl-$(PKG_VERSION)
else
  PKG_SOURCE:=dummy
endif

define Download/vnts2
        URL:=https://github.com/muziling/vnts/releases/download/$(PKG_VERSION)/
        URL_FILE:=$(vnts2_ARCH)
        FILE:=$(vnts2_ARCH)
        HASH:=$(PKG_HASH)
endef

define Package/vnts2
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A virtual network tool server(VPN)
	DEPENDS:=+kmod-tun
	URL:=https://github.com/vnt-dev/vnts
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_vnts2),)
	$(call Download,vnts2)
endif
endef

define Build/Compile
endef

define Package/vnts2/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/vnts2.config $(1)/etc/config/vnts2
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/vnts2.init $(1)/etc/init.d/vnts2
	$(INSTALL_DIR) $(1)/etc/vnts2/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(DL_DIR)/$(vnts2_ARCH) $(1)/usr/bin/vnts2
endef

$(eval $(call BuildPackage,vnts2))
