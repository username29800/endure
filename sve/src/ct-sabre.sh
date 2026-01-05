#!/bin/sh
# sabre-containers extension
prefix=$(cat prefix)
rfspath=$1
mkdir $prefix/system
cp -r ext-alpine* inst-alpine* pkg-alpine* init sysind.sh usrconf.sh cfgnoroot.sh cfgmini.sh utils cs-sabre tools $prefix/system/
cd $prefix/system
#tar -xf $rfspath
