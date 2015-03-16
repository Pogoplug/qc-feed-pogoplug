include $(TOPDIR)/rules.mk

PKG_NAME:=pogoplug
PKG_VERSION:=3.4.5.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.pogoplug.com/qualcomm/
PKG_MD5SUM:=1e30985d87667e8ff976fd2d11b95a50

include $(INCLUDE_DIR)/package.mk

define Package/pogoplug
	SECTION:=base
	CATEGORY:=Network
	DEPENDS:=+librt +libpthread +kmod-tun
	TITLE:=Pogoplug
	URL:=http://www.pogoplug.com
endef

define Package/pogoplug/description
	Pogoplug allows you to attach a hard drive to your router and make the photos, videos, music and documents on all your devices instantly accessible anywhere you go. Protect photos with automatic backups and share them easily with friends and family, stream music and movies to your mobile devices and unlock the potential of your very own personal cloud with Pogoplug.
endef

define Build/Compile
	@echo Not actually compiling anything, just using prebuilt binaries.
endef

define Package/pogoplug/install
	$(INSTALL_DIR) $(1)/usr/local/cloudengines
	$(INSTALL_DATA) ./files/usr/local/cloudengines/hbplug.conf $(1)/usr/local/cloudengines/
	$(INSTALL_DIR) $(1)/usr/local/cloudengines/etc
	$(INSTALL_DIR) $(1)/usr/local/cloudengines/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hbplug $(1)/usr/local/cloudengines/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hbwd $(1)/usr/local/cloudengines/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hbixc $(1)/usr/local/cloudengines/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/hbplug $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/etc/config/pogoplug $(1)/etc/config/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/pogoplug.lua $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/pogoplug
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/pogoplug/pogoplug.lua $(1)/usr/lib/lua/luci/model/cbi/pogoplug/
endef

define Package/pogoplug/conffiles
/etc/init.d/hbplug
endef

define Package/pogoplug/preinst
#!/bin/sh
endef

define Package/pogoplug/postinst
#!/bin/sh
endef

define Package/pogoplug/prerm
#!/bin/sh
/etc/init.d/hbplug stop
/etc/init.d/hbplug disable
endef

define Package/pogoplug/postrm
#!/bin/sh
if [ -f /tmp/hbplug.log ]; then rm /tmp/hbplug.log; fi
if [ -f /usr/local/cloudengines/etc/hbplug.key ]; then rm /usr/local/cloudengines/etc/hbplug.key; fi
if [ -f /usr/local/cloudengines/etc/hbplug.cert ]; then rm /usr/local/cloudengines/etc/hbplug.cert; fi
if [ -d /usr/local/cloudengines/bin ]; then rmdir /usr/local/cloudengines/bin; fi
if [ -d /usr/local/cloudengines/etc ]; then rmdir /usr/local/cloudengines/etc; fi
if [ -d /usr/local/cloudengines ]; then rmdir /usr/local/cloudengines; fi
if [ -d /usr/lib/lua/luci/model/cbi/pogoplug ]; then rmdir /usr/lib/lua/luci/model/cbi/pogoplug; fi
endef

$(eval $(call BuildPackage,pogoplug))
