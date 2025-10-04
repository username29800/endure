#!/bin/sh
# sabre-containers extension
prefix=$(cat prefix)
rfspath=$1
mkdir $prefix/system
cp ext-alpine* inst-alpine* pkg-alpine* cinit pinit initpty sysind.sh $prefix/system/
cd $prefix/system
#tar -xf $rfspath
