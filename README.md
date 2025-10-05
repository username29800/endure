# Endure: Enhanced Network Devlopment / Userland-Run Environment
## What is Endure?
Endure is the successor of alpine-chroot-setup, focused on **connectivity**, **flexibility** and **portability**.

It mainly consists of two components, *system* and *sabre*.
## What is endure made for? (With a little documentation)
As written above, endure is for enhancing the three features, which alpine-chroot-setup lacked:
- connectivity: Sabre included in endure provides better ssh automation.
  - Sabre can help configure connection to every remote user (not only *sidearmconnect*)
  - Sabre does not require root permission, unless you're launching sshd.
  - Sabre stays within its prefix directory; it does not *invade* your /, /bin, /home directories.
> Sabre is **S**ide**A**rm-**B**ox **R**estricted **E**nvironment.
- flexibility / portability: As sabre can be used in various environments, sabre provides more flexible uses than sidearmconnect (alpine-chroot-setup).
  - Sabre can be installed literally anywhere if you have read/write permission.
  - Sabre adopts prefixes to isolate each environment and provide additional flexibility.
    - Among prefixes are prefix, rprefix, sprefix, and pprefix. These are all plain text files.
    - prefix: Where data directory(sidearmconnect) is located. This is the path which *contains* sidearmconnect directory.
    - rprefix: Prefix of the remote sabre instance; This is required when establishing connection to a remote user, which also had sabre configured.
    - sprefix: 'system-prefix'; The directory that *contains* user's .ssh directory. This is needed to register ssh client's pubkey.
    - pprefix: 'prefix-prefix'; The directory that *contains* 'prefix.d/'. This needs to be set up before using: **sacpref**, **sacprefa**, **sacpreset**.
