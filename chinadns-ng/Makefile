include $(TOPDIR)/rules.mk

PKG_NAME:=chinadns-ng
PKG_VERSION:=2024.12.22
PKG_RELEASE:=1
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=zfl9
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

ifeq ($(ARCH),aarch64)
	chinadns-ng_ARCH:=chinadns-ng+wolfssl@aarch64-linux-musl@generic+v8a@fast+lto
else ifeq ($(ARCH),i386)
	chinadns-ng_ARCH:=chinadns-n+wolfsslg@i386-linux-musl@i686@fast+lto
else ifeq ($(ARCH),x86_64)
	chinadns-ng_ARCH:=chinadns-ng+wolfssl@x86_64-linux-musl@x86_64_v4@fast+lto
else
  PKG_SOURCE:=dummy
endif

define Download/chinadns-ng
        URL:=https://github.com/zfl9/chinadns-ng/releases/download/$(PKG_VERSION)/
        URL_FILE:=$(chinadns-ng_ARCH)
        FILE:=$(chinadns-ng_ARCH)
        HASH:=$(PKG_HASH)
endef

define Package/chinadns-ng
	SECTION:=net
	CATEGORY:=Network
	TITLE:=chinadns-ng
	URL:=https://github.com/zfl9/chinadns-ng
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_PACKAGE_chinadns-ng),)
	$(call Download,chinadns-ng)
endif
endef

define Build/Compile
endef

define Package/chinadns-ng/install
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/chinadns-ng.config $(1)/etc/config/chinadns-ng
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/chinadns-ng.init $(1)/etc/init.d/chinadns-ng
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(DL_DIR)/$(chinadns-ng_ARCH) $(1)/usr/bin/chinadns-ng
endef

$(eval $(call BuildPackage,chinadns-ng))
