include $(TOPDIR)/rules.mk

PKG_NAME:=transparent-proxy
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=mzl

include $(INCLUDE_DIR)/package.mk

define Package/transparent-proxy
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Auto bypass with transparent proxy(VPN)
	DEPENDS:=+ipset
endef

define Package/transparent-proxy/conffiles
/etc/config/transparent-proxy
endef

define Build/Compile
endef

define Package/transparent-proxy/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/transparent-proxy.config $(1)/etc/config/transparent-proxy
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/transparent-proxy.init $(1)/etc/init.d/transparent-proxy
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/transparent-proxy.defaults $(1)/etc/uci-defaults/99-transparent-proxy
	$(INSTALL_DIR) $(1)/usr/share/tproxy
	$(INSTALL_DATA) ./files/firewall.include $(1)/usr/share/tproxy/firewall.include
	$(INSTALL_DIR) $(1)/etc/ipset/
	$(INSTALL_DATA) ./files/china.ipset $(1)/etc/ipset/china.ipset
	$(INSTALL_DATA) ./files/vps.ipset $(1)/etc/ipset/vps.ipset
	$(INSTALL_DATA) ./files/china6.ipset $(1)/etc/ipset/china6.ipset
	$(INSTALL_DATA) ./files/vps6.ipset $(1)/etc/ipset/vps6.ipset
endef

$(eval $(call BuildPackage,transparent-proxy))
