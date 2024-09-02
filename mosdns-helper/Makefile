include $(TOPDIR)/rules.mk

PKG_NAME:=mosdns-helper
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=muziling
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/mosdns-helper
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A DNS Forwarder
	DEPENDS:=+mosdns
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/mosdns-helper/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/mosdns.config $(1)/etc/config/mosdns
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/mosdns.init $(1)/etc/init.d/mosdns
endef

$(eval $(call BuildPackage,mosdns-helper))
