include $(TOPDIR)/rules.mk

PKG_NAME:=vnt
PKG_VERSION:=1.2.7
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=lbl8603
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

ifeq ($(ARCH),aarch64)
	VNT_ARCH:=vnt-cli-aarch64-unknown-linux-musl-$(PKG_VERSION).tar.gz
else ifeq ($(ARCH),arm)
	VNT_ARCH:=vnt-cli-armv7-unknown-linux-musleabihf-$(PKG_VERSION).tar.gz
else ifeq ($(ARCH),i386)
	VNT_ARCH:=vnt-cli-i686-unknown-linux-musl-$(PKG_VERSION).tar.gz
else ifeq ($(ARCH),x86_64)
	VNT_ARCH:=vnt-cli-x86_64-unknown-linux-musl-$(PKG_VERSION).tar.gz
else
  PKG_SOURCE:=dummy
endif

define Download/vnt
        URL:=https://github.com/lbl8603/vnt/releases/download/$(PKG_VERSION)/
        URL_FILE:=$(VNT_ARCH)
        FILE:=$(VNT_ARCH)
        HASH:=$(PKG_HASH)
endef

define Package/vnt
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A virtual network tool (VPN)
	URL:=https://github.com/lbl8603/vnt
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_vnt),)
	$(call Download,vnt)
endif
endef

define Build/Compile
endef

define Package/vnt/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/vnt.config $(1)/etc/config/vnt
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/vnt.init $(1)/etc/init.d/vnt
	$(INSTALL_DIR) $(1)/usr/bin
	tar zxvf $(DL_DIR)/$(VNT_ARCH) -C $(1)/usr/bin
endef

$(eval $(call BuildPackage,vnt))
