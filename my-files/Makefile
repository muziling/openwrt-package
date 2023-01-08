include $(TOPDIR)/rules.mk

PKG_NAME:=my-files
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=my-files
endef

define Package/$(PKG_NAME)/description
geoip-cn.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/mosdns
	$(INSTALL_DATA) ./files/geoip_cn.txt $(1)/etc/mosdns/geoip_cn.txt
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
