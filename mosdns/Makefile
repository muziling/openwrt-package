include $(TOPDIR)/rules.mk

PKG_NAME:=mosdns
PKG_VERSION:=5.3.3
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=IrineSistiana
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

ifeq ($(ARCH),aarch64)
	mosdns_ARCH:=mosdns-linux-arm64.zip
else ifeq ($(ARCH),arm)
	mosdns_ARCH:=mosdns-linux-arm64.zip
else ifeq ($(ARCH),x86_64)
	mosdns_ARCH:=mosdns-linux-amd64.zip
else
  PKG_SOURCE:=dummy
endif

define Download/mosdns
        URL:=https://github.com/IrineSistiana/mosdns/releases/download/v$(PKG_VERSION)/
        URL_FILE:=$(mosdns_ARCH)
        FILE:=$(mosdns_ARCH)
        HASH:=$(PKG_HASH)
endef

define Package/mosdns
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A DNS Forwarder
	URL:=https://github.com/IrineSistiana/mosdns/
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_mosdns),)
	$(call Download,mosdns)
endif
endef

define Build/Compile
endef

define Package/mosdns/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/mosdns.config $(1)/etc/config/mosdns
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/mosdns.init $(1)/etc/init.d/mosdns
	$(INSTALL_DIR) $(1)/etc/mosdns/
	$(INSTALL_DIR) $(1)/usr/bin
	unzip $(DL_DIR)/$(mosdns_ARCH) mosdns -d $(1)/usr/bin
endef

$(eval $(call BuildPackage,mosdns))
