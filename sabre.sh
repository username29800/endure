#!/bin/sh
#sabre: Sidearmconnect-Box Restricted Environment
#usage: [script path] [hostkey(private)]
prefix=$(cat prefix)
mkdir $prefix
mkdir $prefix/sidearmconnect
chmod -R 755 $prefix/sidearmconnect
rm $prefix/sidearmconnect/sacsshhkey/key
rm $prefix/sidearmconnect/sacsshpkey/key
# this extension will be installed on user directory.
mkdir $prefix/sidearmconnect/sacsshhkey $prefix/sidearmconnect/sacsshpkey $prefix/sidearmconnect/sacfwdkey $prefix/sidearmconnect/sacsshckey $prefix/sidearmconnect/rcvdest $prefix/.ssh
ln -sf "$(pwd | sed s,/$,,)"/"$1" $prefix/sidearmconnect/sacsshhkey/key
ln -sf "$(pwd | sed s,/$,,)"/"$1".pub $prefix/sidearmconnect/sacsshpkey/key
