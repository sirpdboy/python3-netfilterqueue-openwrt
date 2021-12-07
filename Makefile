#
# Copyright (C) 2007-2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-netfilterqueue
PKG_VERSION:=0.8.1
PKG_RELEASE:=1

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/sirpdboy/python-netfilterqueue/archive/
PKG_MD5SUM:=f5cd46135d5d71185ca0d56c728d806f

PKG_BUILD_DEPENDS:=python3

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-netfilterqueue
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=Python bindings for libnetfilter_queue
	URL:=https://github.com/sirpdboy/python-netfilterqueue/
	DEPENDS:=+python3 +libnetfilter-queue
endef

define PyPackage/python-netfilterqueue/filespec
+|$(PYTHON_PKG_DIR)/netfilterqueue.so
endef

define Build/Compile
	$(if $(Build/Compile/PyMod),,@echo Python packaging code not found.; false)
	$(call Build/Compile/PyMod,., \
		install --prefix="$(PKG_INSTALL_DIR)/usr" \
	)
endef

$(eval $(call PyPackage,python-netfilterqueue))
$(eval $(call BuildPackage,python-netfilterqueue))

