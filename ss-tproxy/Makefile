include $(TOPDIR)/rules.mk

PKG_NAME:=ss-tproxy-lite
PKG_VERSION:=4.6.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=ss-tproxy-lite is a linux transparent-proxy rule script
	DEPENDS:=+sudo +ipset +kmod-nf-nathelper +kmod-nf-nathelper-extra +kmod-ipt-tproxy +kmod-ipt-raw +iptables-mod-extra +iptables-mod-conntrack-extra +iptables-mod-tproxy 
	USERID:=proxy=953:proxy=953
	URL:=https://github.com/muziling/openwrt-package
endef

define Package/$(PKG_NAME)/description
ss-tproxy-lite is a linux transparent-proxy rule script, remove dns rule from https://github.com/zfl9/ss-tproxy.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/ss-tproxy
	$(INSTALL_DATA) ./files/config/* $(1)/etc/ss-tproxy/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/bin/ss-tproxy $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
