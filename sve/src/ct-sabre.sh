#!/bin/sh
# sabre-containers extension
#prefix=$(cat prefix)
#rfspath=$1
mkdir -p ${ct_system}/system
#cp -r ext-alpine* inst-alpine* pkg-alpine* init sysind.sh usrconf.sh cfgnoroot.sh cfgmini.sh utils cs-sabre tools $prefix/system/
cp -a ${ct_path}/initptyc ${ct_system}/initptyc
cd ${ct_system}/system
chmod 755 initptyc
mkdir mem rmem
