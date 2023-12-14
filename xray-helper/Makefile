include $(TOPDIR)/rules.mk

PKG_NAME:=xray-helper
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=muziling
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/xray-helper
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A xray helper contain etc config and init.d
	DEPENDS:=+xray-core
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/xray-helper/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/xray.config $(1)/etc/config/xray
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/xray.init $(1)/etc/init.d/xray
endef

$(eval $(call BuildPackage,xray-helper))
