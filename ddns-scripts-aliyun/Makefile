include $(TOPDIR)/rules.mk

PKG_NAME:=ddns-scripts-aliyun
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	PKGARCH:=all
	TITLE:=Extension for aliyun API
	DEPENDS:=+ddns-scripts +wget-ssl
	URL:=https://github.com/muziling/openwrt-package
endef

define Package/$(PKG_NAME)/description
  Dynamic DNS Client scripts extension for aliyun API (require wget-ssl)
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
        $(INSTALL_DIR) $(1)/usr/lib/ddns
        $(INSTALL_BIN) ./files/update_aliyun_com.sh $(1)/usr/lib/ddns

        $(INSTALL_DIR) $(1)/usr/share/ddns/default
        $(INSTALL_DATA) ./files/aliyun.com.json $(1)/usr/share/ddns/default/
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
        /etc/init.d/ddns stop
fi
exit 0
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
