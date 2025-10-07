#!/bin/sh
# sabre-containers extension
prefix=$(cat prefix)
rfspath=$1
mkdir $prefix/system
cp -r ext-alpine* inst-alpine* pkg-alpine* cinit pinit initpty cinitc pinitc initptyc sysind.sh sabre.sh utils tools $prefix/system/
cd $prefix/system
#tar -xf $rfspath
