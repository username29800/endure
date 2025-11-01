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
1. Sabre

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
   - Termux
   - Proot on Termux
   - FreeBSD (Yes, it works.)

     NOTE: Cygwin is not compatible.

2. CT-Sabre

CT-Sabre stands for **C**on**T**ainer-Sabre. It includes a set of scripts for chroot containers.

CT-Sabre provides functionalities of:

   - Creating a root directory for a new chroot container, under the current Sabre prefix.
   - Setting up other components (eux, eau, sabre) for the newly created container
   - Troubleshooting a proot container after migration (specific to proot)
   - A large variety of chroot/proot init scripts for interactive/non-interactive operations

3. Eux (Endure UX)

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

4. EAU (Endure Alpine Utilities)
EAU provides scripts for setting up an alpine linux system. This component supports alpine linux on:
   - Bare-metal
   - Virtual machine
   - Container (Docker, Podman, chroot, proot)
EAU includes scripst for:
   - Installing base system
   - Installing recommended text editors (via apk and source)
   - Installing and configuring virtualbox guest addition
