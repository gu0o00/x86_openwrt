#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

rm -rf feeds/luci/themes/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

# Modify default IP
sed -i 's/192.168.1.1/10.0.0.100/g' package/base-files/files/bin/config_generate

## 下载OpenClash
wget https://github.com/vernesong/OpenClash/archive/master.zip

## 解压
unzip master.zip

## 复制OpenClash软件包到OpenWrt
cp -r OpenClash-master/luci-app-openclash ./package

cd ./package

# 编译 po2lmo (如果有po2lmo可跳过)
pushd luci-app-openclash/tools/po2lmo
make && sudo make install
popd

cd ..

# update upnp source
sed -i 's/miniupnp.tuxfamily.org/miniupnp.free.fr/g' openwrt/package/feeds/packages/miniupnpd/Makefile