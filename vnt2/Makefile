include $(TOPDIR)/rules.mk

PKG_NAME:=vnt2
PKG_VERSION:=v2.0.8
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=lbl8603
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

ifeq ($(ARCH),aarch64)
	vnt2_ARCH:=vnt2-aarch64-unknown-linux-musl-$(PKG_VERSION).zip
else ifeq ($(ARCH),arm)
	vnt2_ARCH:=vnt2-armv7-unknown-linux-musleabihf-$(PKG_VERSION).zip
else ifeq ($(ARCH),x86_64)
	vnt2_ARCH:=vnt2-x86_64-unknown-linux-musl-$(PKG_VERSION).zip
else
  PKG_SOURCE:=dummy
endif

define Download/vnt2
        URL:=https://github.com/muziling/vnt/releases/download/$(PKG_VERSION)/
        URL_FILE:=$(vnt2_ARCH)
        FILE:=$(vnt2_ARCH)
        HASH:=$(PKG_HASH)
endef

define Package/vnt2
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A virtual network tool (VPN)
	DEPENDS:=+kmod-tun
	URL:=https://github.com/vnt-dev/vnt2
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_vnt2),)
	$(call Download,vnt2)
endif
endef

define Build/Compile
endef

define Package/vnt2/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/vnt2.config $(1)/etc/config/vnt2
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/vnt2.init $(1)/etc/init.d/vnt2
	$(INSTALL_DIR) $(1)/usr/bin
	unzip $(DL_DIR)/$(vnt2_ARCH) -d $(1)/usr/bin
endef

$(eval $(call BuildPackage,vnt2))
