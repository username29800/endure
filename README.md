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
   - MSYS2 (X11 forwarding not available) \
     **NOTE:** Cygwin is **not** compatible.
   - Termux
   - Proot on Termux
   - FreeBSD (Yes, it works.)

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
### Getting Endure
To obtain the latest version of Endure, run: \
git clone https://github.com/username29800/endure

### Setting up Sabre
Before using any feature, Sabre, the **core** of endure, should be set up. \
Sabre requires two files to be installed properly: **prefix, pprefix**. You can literally use any method to write these files. For example, run: \
echo test > prefix \
echo preset > pprefix \
