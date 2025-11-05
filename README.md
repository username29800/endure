# Endure: Enhanced, Network-Driven Unified Runner Environment
## What is Endure?
Endure is an utility framework for operating multiple unix-like systems at once.

## What is endure made for?
|| TL;DR || Endure integrates multiple linux/unix-like systems into one workflow.

- 1. Endure provides a set of scripts for managing connections from/to remote system.
- 2. Endure provides specific directory structure to store data for each remote.
- 3. Endure provides a few utilities for creating and managing chroot-containerized systems.
- 4. Endure is compatible in lots of unix-like systems.

## Features and Components
### 1. Sabre

   Sabre is the abbreviation of "**S**ide**A**rm-Connect-**B**ox, **R**estricted **E**nvironment". This component is the **core** of Endure, being reponsible for *connectivity* between systems.
   
   As the name suggests, Sabre is a continuation of the 'linux-sidearm' *(or sidearmconnect)* component from the 'alpine-chroot-setup' project. However, Sabre differs from linux-sidearm, storing the whole data in a separated directory.

   Based on the separation method, Sabre has features to manage multiple remote environments, using the prefix system, which is also the base of some other components.

   Sabre provides utility scripts to help:

   - Register ssh id keys for remote host connection. This can be configured *individually* for each host.
   - Send the registered id key to remote host. This requires password during an initial setup.
   - Manage allowed keys among the received keys.
     *NOTE*: This feature modifies the '.ssh/authorized\_keys' file.
   - Send a file to remote host. Received file is stored under '$prefix/sidearmconnect/rcvdest' directory.
   - Send xauth key to remote host. This is for simplifying trusted X11 forwarding.

   Sabre is compatible with:

   - Modern Linux distributions
   - WSL (Tested on Ubuntu)
   - MSYS2 (X11 forwarding not available)
   - Cygwin (X11 forwarding available) \
     **NOTE:** Cygwin is **not** compatible with key-based ssh authentication. (Permission/ACL issues)
   - Termux
   - Proot on Termux
   - FreeBSD (Yes, it works.)

   To enable X11 forwarding on Cygwin, add a display to xauth by running:
   ```bash
xauth add :0 MIT-MAGIC-COOKIE $(mcookie)
   ```
#### 1-1. CS-Sabre

CS-Sabre(Cluster-Sabre) is the advanced, automation-focused version of Sabre. This component makes use of a configuration file. This file is called 'database' as it contains connection info.

CS-Sabre features:
- Connection management in one database file, instead of prefix.d
- Database files can be shared
- Prefix directories can be built from database entries
- Ability to build a mutually connected network using a shared database file

A database entry looks like this:
```
[alias] [prefix] [rprefix] [hostname] [port] [user]
pk_alias [pubkey]

#sample entry
default getting-started /home/user/endure/getting-started localhost 22 user
pk_default [pubkey]

#sample client-only entry: alias, prefix, pubkey only
client client
pk_client [pubkey]

#sample server-only entry: no pubkey
default getting-started /home/user/endure/getting-started localhost 22 user
```
CS-Sabre utilities require two common arguments: \[database file\] and \[entry name\].


### 2. CT-Sabre

CT-Sabre stands for **C**on**T**ainer-Sabre. It includes a set of scripts for chroot containers.

CT-Sabre provides functionalities of:

   - Creating a root directory for a new chroot container, under the current Sabre prefix.
   - Setting up other components (eux, eau, sabre) for the newly created container
   - Troubleshooting a proot container after migration (specific to proot)
   - A large variety of chroot/proot init scripts for interactive/non-interactive operations

### 3. Eux (Endure UX)

This component provides scripts to set up a ready-to-use environment. This provides a shared UX to integrate workflow more easily.

Eux includes:

   - System-wide configuration for newly installed systems (superuser previlege required)
     - Preconfigured xsession (Openbox or MATE)
     - Workarounds/Utilities under /bin
     - Automated password setup for specified user
     - Automatically adds specified user to sudoers file
   - User-specific configurations
     - .profile configuration
       - PulseAudio server set to localhost
       - IBus set as the default IM by default
     - Workarounds and Utilities under Home Directory
     - Basic Home Directory Structure
     - Minimal Vim configuration
     - xstartup preconfigured for vnc session

### 4. EAU (Endure Alpine Utilities)

EAU provides scripts for setting up an alpine linux system. This component supports alpine linux on:
   - Bare-metal
   - Virtual machine
   - Container (Docker, Podman, chroot, proot)

EAU includes scripts for:
   - Installing base system
   - Installing recommended text editors (via apk and source)
   - Installing and configuring virtualbox guest addition

## Scripts and Files
### Sabre
- sabre.sh : The setup script for Sabre. Running this would create a new Sabre instance with identity key / hostkey. \
  Arguments(2): \[absolute/relative path to ssh id key] \[path ref point: $PWD or (blank)\]
- utils/ : The directory for Sabre utilities. \
  **IMPORTANT**: These utils relies on prefix files, and therefore called(executed) from the Sabre root directory, where prefix files reside.
  - sacsshcon : SSH | Connect to a remote host. \
    Arguments(3): \[ip/hostname\] \[port\] \[user\]
  - sasshsvl / sacrunsshd : SSH | Launch sshd. Root previlege required. \
    Argument(1): \[port\] \
    **NOTE:** This is not likely to work in systemd-enabled environment.
  - sacsendkey : SSH | Send a ssh id key to remote. \
    Arguments(4): ip/hostname port key-name user
  - sacsendf : SSH | Send a file to remote. \
    Arguments(5): ip/hostname port filesource filename user
  - sacauthkey / sacregkey : SSH | Authenticate received id key. \
    Argument(1): key-name
  - sacunregkey : SSH | Delete a key from authorized\_keys. \
    Argument(1): key-name
  - sacsendxkey : X11 | Send a xauth cookie to remote. \
    Arguments(4): ip/hostname port line-number user
  - sacauthxkey : X11 | Authenticate received xauth cookie.
  - sacfixfwdhost : X11 | Fix Display variable in xauth cookie. \
    Argument(1): display-location
  - sacprefa : Local | Restore prefix preset from prefix.d . \
    Argument(1): preset-name
  - sacpreset : Local | Save current prefix as a preset. \
    Argument(1): preset-name

### CT-Sabre
- ct-sabre.sh : The setup script for CT-Sabre. This installs some scripts under '$prefix/system/' .  You should still decompress rootfs manually. *No argument required.*
- tools/rewire-(old|rc|ng|n2) : Tools for rewriting link2symlink destinations after proot container migration. May take a long time. (Estimated 3min-5min for newly installed alpine linux containers) It is recommended to use ng (fileless) / n2 (faster) variant.
- launch scripts : A set of scripts to launch container for various purposes
  - pinit / cinit : Basic launch scripts, respectively for proot and chroot. Should be run from the new root directory. \
    Arguments(2): \[User\]
  - pinitc / cinitc : For internal use.
  - initpty : Supplemental script for cinit; Mounts and allocates devpts (pty) for a container.
  - pstart / cstart : Convenience-first wrappers. Can be run from the Sabre root directory. Prefix file (prefix) required. \
    Arguments(2): \[User\] \[Command\]
  - ctsp / ctsc : Launch proot / chroot, go to cprefix path, then runs a command. Cprefix file (cprefix) required. \
    Arguments(2): \[User\] \[Command\]

### Eux
- sysind.sh : System-wide, Alpine-chroot-setup User Experience setup script for user 'user'. Root previlege required. *Deprecated*
- usrconf.sh : System-wide, Eux setup script. Root previlige required. *Almost deprecated* \
  Argument(1): \[User\]
- cfgnoroot.sh : User-specific, Eux setup script. Current default for Eux setup. \
  Arguments(2): \[your home dir\] \[path to endure root\]
- cfgmini.sh : User-specific, Eux setup script. Current minimal option for Eux setup. D2Coding font and Oh-My-Zsh installation is excluded. Recommended for network-limited environment. \
  Arguments(2): \[your home dir\] \[path to endure root\]

### Eau
This would be explained in Getting Started section below.

## Getting Started
### Prerequisites
- Required
  - openssh-server
  - openssh-client
  - basic shell : sh / bash
  - git
- Recommended
  - vim
  - zsh
  - xserver

### Obtaining Endure via git
To obtain the latest version of Endure, run: \
git clone https://github.com/username29800/endure

### Setting up Sabre
Before using any feature, Sabre, the **core** of endure, should be set up. \
First of all, go to the cloned repository.
```bash
cd endure
```
This implies that all the steps below should take place in endure root directory (~/endure by default).
Sabre requires two files to be installed properly: **prefix, pprefix**. You can literally use any method to write these files. For example, run:
```bash
echo test > prefix
echo preset > pprefix
```
After creating prefix files, a ssh key should be created. Run:
```bash
mkdir ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
```
Finally, Sabre can be installed. Run:
```bash
sh utils/sabre.sh ../.ssh/id_rsa $PWD
```
When setting up a new connection, you can follow this steps again (with a different ssh key) to separate auth keys and data for each connection. \
If you don't need to separate data storage, you can only change rprefix as written below.

NOTE: A prefix is the name of a connection, sprefix is the path to the parent directory of .ssh, and pprefix is a path to the directory containing the prefix.d directory.

### Configuring a connection
Sabre can configure connection to remote Sabre instance. This requires rprefix to specify remote Sabre prefix location. You can write this using any method. For example, run:
```bash
echo /home/user/endure/test > rprefix
```
To manage connections from remote, a sprefix file is needed. The file content is the parent directory of .ssh directory. For example, run:
```bash
# simple method
echo .. > sprefix
# more stable version
echo /home/user > sprefix
```
Congratulations. Now you've all set up for making a connection to a remote Sabre instance.

#### Alternative: Setting up CS-Sabre
CS-Sabre provides more convenience with the power of its database format. To configure CS-Sabre, you need to configure pprefix and sprefix, with an additional database file. \
Fortuately, you have a database example for testing:
```
#sample client+server entry
test test /home/user/endure/test localhost 22 user
```
You can save this as a file 'db.test', or write a custom entry from scratch. Note that this entry wouldn't work if you don't adjust some values(e.g. username). \
To configure CS-Sabre with this entry, run:
```bash
#syntax: [csprofile] [database] [alias]
sh cs-sabre/csprofile db.test test
```
The configured preset is compatible with the Parallel Preset System in Sabre.

#### Sending and registering an id key using CS-Sabre
CS-Sabre enables the ability to share and store multiple public keys in a single database file. Thus, you can now share a database file with nodes(remotes) to build an interconnected workflow network. \
You can attach a public key to an entry with:
```bash
sh cs-sabre/csakey [database] [alias] [pubkey file]
```
Then send this file to remote:
```bash
sh cs-sabre/cssend [database] [remote alias] [database file] [remote filename]
```
And then accept the key:
```bash
sh cs-sabre/cspkey [database] [client alias]
```

#### All CS-Sabre operations
```
#connect to remote
cscon [database] [remote alias]

#ssh tunneling
csfwd [database] [remote alias] [portforwarding rule]

#send file
cssend [database] [remote alias] [source] [received file name]

#attach key
csakey [database] [client alias] [pubkey]

#accept key
cspkey [database] [client alias]

#deauthorize key
csdkey [database] [client alias]

#run sshd
csserver [database] [self alias]
#NOTE: In distros that use systemd, use systemctl instead.

#edit display name in MIT-MAGIC-COOKIE
csxdpy [database] [self alias] [display]

#accept x11 fwd key
csxkey [database] [self alias]
```

### Sending and registering an id key
You can use a key-based authentication without password entry. Run:
```bash
sh utils/sacsendkey [remote host] [port] [key identifier (random name)] [user]
```
If you're connecting to the host for the first time, answer 'yes' to the prompt. Then, enter a password for the user you're connecting to. \
On the server side, run:
```bash
sh utils/sacauthkey [key name]
```
From then, you can connect to remote Sabre instance without command. The sacsshcon utility makes this way easier:
```bash
sh utils/sacsshcon [remote host] [port] [user]
```

### Saving current configuration as a preset
To save these prefix files (prefix, sprefix, rprefix), run:
```bash
sh utils/sacpreset [preset name]
```
To restore that preset, run:
```bash
sh utils/sacprefa [preset name]
```

#### Alternative: The Parallel Preset System
Sabre newly supports an alternative to the traditional preset system. When configuring a Sabre instance (using ./sabre.sh), current prefix files are copied to the prefix directory, with path adjustment. \
You can now just chdir to a prefix directory, and call Sabre/CT-Sabre utilities. It is highly recommended to install Eux when using this method. \
This new system makes it easier to connect to multiple remotes at once, without switching presets.

### Installing Eux
Eux provides a shared User Experience among multiple systems you would connect using Sabre. To install Eux, run:
```bash
sh cfgnoroot.sh $HOME $PWD
```
To exclude any network usage, run:
```bash
sh cfgmini.sh $HOME $PWD
```
TIP: To integrate shells other than zsh and sh, copy the content of .zshrc.1 into your shell configuration file. For example:
```bash
cp ~/.zshrc.1 ~/.bashrc
```
NOTE: Eux now provides the Endure Path Extension feature. You can run Sabre/CT-Sabre utilities from anywhere. (Calling these scripts still requires prefix files)
