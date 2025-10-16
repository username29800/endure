#!/bin/sh
#user experience configuration utility - nonroot version
echo 'usage: sh cnfnoroot.sh [your home dir] [path to endure root]'
src=$2
dest=$1
mkdir $dest/bin
mkdir $dest/build
cd $dest/build
#echo 'adduse.r/psw.d/
#adduse.r/psw.d/' | passwd $user
#echo vncpasswd - enter a new vnc password
echo "adusr.wd
adusr.wd
n" | vncpasswd
cd $dest
mkdir Downloads Documents Pictures Music Videos Projects
mkdir -p .config/tigervnc
echo 'export GTK_IM_MODULE=ibus' > .zshrc.1
echo 'export QT_IM_MODULE=ibus' >> .zshrc.1
echo 'export XMODIFIERS=@im=ibus' >> .zshrc.1
echo 'export PULSE_SERVER=localhost' >> .zshrc.1
cp .zshrc.1 .config/tigervnc/xstartup
echo 'xrandr --output VNC-0 --mode 1920x1080' >> .config/tigervnc/xstartup
echo 'openbox' >> .config/tigervnc/xstartup
ln -sf .config/tigervnc/xstartup
echo '#!/bin/sh' > $dest/bin/safefox
echo 'export MOZ_FAKE_NO_SANDBOX=1' >> $dest/bin/safefox
echo 'firefox $1' >> $dest/bin/safefox
chmod 755 $dest/bin/safefox
echo '#!/bin/sh' > $dest/bin/showw
echo 'rofi -show window &' >> $dest/bin/showw
chmod 755 $dest/bin/showw
echo '#!/bin/sh' > $dest/bin/sdclock
echo 'xclock -digital -update 10 &' >> $dest/bin/sdclock
chmod 755 $dest/bin/sdclock
cp $src/utils/tlch $dest/bin/tlch
cp $src/utils/tlch $dest/bin/twrapper
cp $src/utils/tlch $dest/bin/tlaunch
chmod 744 .config/tigervnc/xstartup
mkdir .vnc
cp xstartup .vnc/xstartup
#mkdir /usr/share/xsessions
#echo '[Desktop Entry]' > /usr/share/xsessions/custom.desktop
#echo 'Name=Custom' >> /usr/share/xsessions/custom.desktop
#echo 'Exec=/home/'"$user"'/xstartup' >> /usr/share/xsessions/custom.desktop
#echo 'Type=application' >> /usr/share/xsessions/custom.desktop
cp /utils/swsh $dest/swsh
#echo "LD_PRELOAD=/system/lib64/libskcodec.so pulseaudio --load='module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1'" > /sndsrv
#sed -i 1i"#\!/bin/sh" /sndsrv
#chmod 755 /sndsrv
cd $dest/build
git clone https://github.com/naver/d2codingfont
git clone https://github.com/ohmyzsh/ohmyzsh
mkdir $dest/.fonts
unzip d2codingfont/D2Coding-Ver1.3.2*.zip
cp D2Coding/*.ttf $dest/.fonts
fc-cache
echo 'set nocp number autoindent tabstop=2 shiftwidth=2 expandtab printheader=""' > $dest/.vimrc
#chown -R $user $dest/bin
chmod -R 755 $dest/build/ohmyzsh
sed -ir 's,^.*zsh -l$,#&,' $dest/build/ohmyzsh/tools/install.sh
sh $dest/build/ohmyzsh/tools/install.sh
cat $dest/.zshrc.1 >> $dest/.zshrc
sed -ir "$(cat $dest/.zshrc | grep -n ^ZSH_THEME | head -n1 | cut -d: -f-1)"'s,=.*\?$,="agnoster",' $dest/.zshrc
exit
