include $(TOPDIR)/rules.mk

PKG_NAME:=autocf
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=auto test and change cloudflare ip
	DEPENDS:=+bash +sudo +fping
	URL:=https://github.com/muziling/openwrt-package
endef

define Package/$(PKG_NAME)/description
auto test and change cloudflare ip.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/autocf
	$(INSTALL_DATA) ./files/* $(1)/etc/autocf/
	$(INSTALL_DIR) $(1)/etc/crontabs
	echo "#30 * * * * bash /etc/autocf/updateip.sh 500" >> $(1)/etc/crontabs/root
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
