#!/bin/sh
#This header file defines the variables interpreted by d2efbuild.
#Each variable can be called in a header definition file, to make it easier to define a variable.
sq=\'
dq=\"
pchar=\|
redir=\>
bksh=\\
apnd='>>'
pos='cut -d'${sq}' '${sq}' -f'
linum='grep -n '$sq'.\?'$sq
ln='head -n1'
tr='tr -d \n'
q86='qemu-system-x86 -machine q35 -cpu max -accel kvm'
q86dev='-device virtio-net-pci,netdev=unet -net user,id=unet -device virtio-scsi-pci'
echo csdb=\$\(cat \$1\) >> $1
echo entryname=\$\(echo \$2\) >> $1
echo entry=\$\(echo $dq\$csdb$dq $pchar grep ${sq}^${sq}'$entryname'$sq $sq $pchar $ln\) >> $1
echo prefix=\$\(echo \$entry $pchar ${pos}2 $pchar $ln\) >> $1
echo sprefix=\$\(echo $dq\$csdb$dq $pchar grep ${sq}'^cfg_sprefix '$sq $pchar ${pos}2- $pchar $ln\) >> $1
echo pprefix=\$\(echo $dq\$csdb$dq $pchar grep ${sq}'^cfg_pprefix '$sq $pchar ${pos}2- $pchar $ln\) >> $1
echo rprefix=\$\(echo \$entry $pchar ${pos}3\) >> $1
echo hostname=\$\(echo \$entry $pchar ${pos}4\) >> $1
echo port=\$\(echo \$entry $pchar ${pos}5\) >> $1
echo user=\$\(echo \$entry $pchar ${pos}6\) >> $1
echo pkey=\$\(echo $dq\$csdb$dq $pchar grep ${sq}^${sq}'$pkeyformat$entryname'$sq $sq $pchar ${pos}2- $pchar $ln\) >> $1
echo cscmd=\$\(echo $dq\$3$dq\) >> $1
echo fwdrule=\$\(echo \$3\) >> $1
echo keyfile=\$\(echo \$3\) >> $1
echo pathbase=\$\(echo \$4\) >> $1
echo fsource=\$\(echo \$3\) >> $1
echo fdest=\$\(echo \$4\) >> $1
echo xline=\$\(echo \$3\) >> $1
echo dpyname=\$\(echo \$3\) >> $1
echo lport=\$\(echo $dq\$csdb$dq $pchar grep ${sq}'^listen_'${sq}'$entryname'$sq $sq $pchar ${pos}2 $pchar $ln\) >> $1
echo entryline=\$\(echo $dq\$csdb$dq $pchar 'grep -n .'$pchar grep ${sq}'^[0-9]*:'${sq}'$entryname'$sq $sq $pchar cut -d: -f1 $pchar $ln\) >> $1
echo pkeyformat=\$\(echo $dq\$csdb$dq $pchar grep ${sq}'^cfg_pkeyformat '$sq $pchar ${pos}2- $pchar $ln\) >> $1
echo keystring=\$\(cat \$3\) >> $1
echo dbfile=\$\(echo \$1\) >> $1
echo q86e=\$\(echo $q86 $q86dev\) >> $1
echo q86root=\$\(echo 'sudo $q86e'\) >> $1
