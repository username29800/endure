#!/bin/sh
#sabre: Sidearmconnect-Box Restricted Environment
#Sabre is a non-root, improved implementation of sidearmconnect.
#howto: (1) create prefix specification file(echo . > prefix) (2) create rprefix(remote prefix) to connect to remote, or create sprefix(sys-prefix) to automate ssh key registration
#prefix is the installation directory(where sabre data directory-'sidearmconnect'-will be generated), sprefix is where a user's .ssh is located, rprefix is the prefix of the remote instance of sabre.
#NOTE: every prefix should not contain trailing slash(es); They may cause errors. To filter out the slashes automatically, pipe stdout into "sed 's,/$,,'"
#example: echo . > prefix ; echo /home/user-example > sprefix ; echo /home/user-remote/endure > rprefix
#usage: [script path] [hostkey(private)]
prefix=$(cat prefix)
pprefix=$(cat pprefix)
pathbase=$2
#set pathbase to $(pwd) or $PWD in order to specify relative path
#with empty pathbase, the absolute path provided by $1 will be used
#to configure with absolute path, exclude preceding '/' (root directory representation) from the pathbase ($2) argument.
mkdir $pprefix/prefix.d
mkdir $prefix
mkdir $prefix/sidearmconnect
chmod -R 755 $prefix/sidearmconnect
rm $prefix/sidearmconnect/sacsshhkey/key
rm $prefix/sidearmconnect/sacsshpkey/key
# this extension will be installed on user directory.
mkdir $prefix/sidearmconnect/sacsshhkey $prefix/sidearmconnect/sacsshpkey $prefix/sidearmconnect/sacfwdkey $prefix/sidearmconnect/sacsshckey $prefix/sidearmconnect/rcvdest $prefix/.ssh
ln -sf "$(echo $pathbase | sed s,/$,,)"/"$1" $prefix/sidearmconnect/sacsshhkey/key
ln -sf "$(echo $pathbase | sed s,/$,,)"/"$1".pub $prefix/sidearmconnect/sacsshpkey/key
