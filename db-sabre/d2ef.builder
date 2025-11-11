#!/bin/sh
#csparse: a line parser for db-sabre
sq=\'
dq=\"
pchar=\|
redir=\>
apnd='>>'
pos0='cut -d\  -f'
linum='grep -n '$sq'.\?'$sq
ln='head -n1'
tr='tr -d \n'
q86='qemu-system-x86 -machine q35 -cpu max -accel kvm'
q86dev='-device virtio-net-pci,netdev=unet -net user,id=unet -device virtio-scsi-pci'
echo csdb=\$\(cat \$1\) >> $1
echo entry=\$\(echo ${dq}\$csdb$dq\) >> $1
echo qemu=\$\(sudo $q86 $q86dev\) >> $1
