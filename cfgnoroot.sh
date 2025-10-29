#!/bin/sh
#user experience configuration utility - nonroot version
echo 'usage: sh cnfnoroot.sh [your home dir] [path to endure root]'
src=$2
dest=$1
mkdir $dest/eux-utils
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
mv $dest/.profile $dest/.profile.eux.b
echo 'export GTK_IM_MODULE=ibus' > .profile
echo 'export QT_IM_MODULE=ibus' >> .profile
echo 'export XMODIFIERS=@im=ibus' >> .profile
echo 'export PULSE_SERVER=localhost' >> .profile
cp .zshrc.1 .config/tigervnc/xstartup
echo 'xrandr --output VNC-0 --mode 1920x1080' >> .config/tigervnc/xstartup
echo 'openbox' >> .config/tigervnc/xstartup
ln -sf .config/tigervnc/xstartup
echo '#!/bin/sh' > $dest/eux-utils/safefox
echo 'export MOZ_FAKE_NO_SANDBOX=1' >> $dest/eux-utils/safefox
echo 'firefox $1' >> $dest/eux-utils/safefox
chmod 755 $dest/eux-utils/safefox
echo '#!/bin/sh' > $dest/eux-utils/showw
echo 'rofi -show window &' >> $dest/eux-utils/showw
chmod 755 $dest/eux-utils/showw
echo '#!/bin/sh' > $dest/eux-utils/sdclock
echo 'xclock -digital -update 10 &' >> $dest/eux-utils/sdclock
chmod 755 $dest/eux-utils/sdclock
cp $src/utils/tlch $dest/eux-utils/tlch
cp $src/utils/tlch $dest/eux-utils/twrapper
cp $src/utils/tlch $dest/eux-utils/tlaunch
chmod 744 .config/tigervnc/xstartup
mkdir .vnc
cp xstartup .vnc/xstartup
#mkdir /usr/share/xsessions
#echo '[Desktop Entry]' > /usr/share/xsessions/custom.desktop
#echo 'Name=Custom' >> /usr/share/xsessions/custom.desktop
#echo 'Exec=/home/'"$user"'/xstartup' >> /usr/share/xsessions/custom.desktop
#echo 'Type=application' >> /usr/share/xsessions/custom.desktop
cp $src/utils/swsh $dest/swsh
echo "LD_PRELOAD=/system/lib64/libskcodec.so pulseaudio --load='module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1'" > $dest/eux-utils/sndsrv
sed -i 1i"#\!/bin/sh" $dest/eux-utils/sndsrv
chmod 755 $dest/eux-utils/sndsrv
cd $dest/build
git clone https://github.com/naver/d2codingfont
git clone https://github.com/ohmyzsh/ohmyzsh
mkdir $dest/.fonts
unzip d2codingfont/D2Coding-Ver1.3.2*.zip
cp D2Coding/*.ttf $dest/.fonts
fc-cache
echo 'set nocp number autoindent tabstop=2 shiftwidth=2 expandtab printheader=""' > $dest/.vimrc
#chown -R $user $dest/eux-utils
chmod -R 755 $dest/build/ohmyzsh
sed -ir 's,^.*zsh -l$,#&,' $dest/build/ohmyzsh/tools/install.sh
sh $dest/build/ohmyzsh/tools/install.sh
cat $dest/.zshrc.1 >> $dest/.zshrc
sed -ir "$(cat $dest/.zshrc | grep -n ^ZSH_THEME | head -n1 | cut -d: -f-1)"'s,=.*\?$,="agnoster",' $dest/.zshrc
exit
