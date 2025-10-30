# Endure: Enhanced, Network-Driven Unified Runner Environment
## What is Endure?
Endure is an utility framework for operating multiple unix-like systems at once.

## What is endure made for?
|| TL;DR || Endure groups multiple linux/unix-like systems into one workflow.

- 1. Endure provides a set of scripts for managing connections from/to remote system.
- 2. Endure provides specific directory structure to store data for each remote.
- 3. Endure provides a few utilities for creating and managing chroot-containerized systems.
- 4. Endure is compatible in lots of unix-like systems.

## Features and Components
1. Sabre

   Sabre is the abbreviation of "**S**ide**A**rm-Connect-**B**ox, **R**estricted **E**nvironment". This component is the **core** of Endure, being reponsible for *connectivity* between systems.
   
   As the name suggests, Sabre is a continuation of the 'linux-sidearm' *(or sidearmconnect)* component from the 'alpine-chroot-setup' project. However, Sabre differs from linux-sidearm, storing the whole data in a separated directory.

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
     NOTE: Cygwin is not compatible.
   - Termux
   - Proot on Termux
   - FreeBSD (Yes, it works.)
