#!/bin/sh
# sabre-containers extension
#prefix=$(cat prefix)
#rfspath=$1
mkdir -p ${ct_system}/system
#cp -r ext-alpine* inst-alpine* pkg-alpine* init sysind.sh usrconf.sh cfgnoroot.sh cfgmini.sh utils cs-sabre tools $prefix/system/
cp -a ${ct_path}/initpty ${ct_system}/initpty
cd ${ct_system}/system
mkdir mem rmem
