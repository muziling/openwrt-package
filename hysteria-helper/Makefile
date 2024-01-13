include $(TOPDIR)/rules.mk

PKG_NAME:=hysteria-helper
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=muziling
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/hysteria-helper
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A hysteria helper contain etc config and init.d
	DEPENDS:=+hysteria
	USERID:=hysteria=2000:hysteria=2000
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/hysteria-helper/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/hysteria.config $(1)/etc/config/hysteria
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/hysteria.init $(1)/etc/init.d/hysteria
endef

$(eval $(call BuildPackage,hysteria-helper))
