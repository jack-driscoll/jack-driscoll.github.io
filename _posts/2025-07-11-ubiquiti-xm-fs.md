---
layout: post
title: "The Ubiquiti XM Filestysem: A Definitive Guide by nTeleKy"
date: 2025-07-11
permalink: /2025-07-11-ubiquiti-xm-fs.html
tags: [article, internet, embedded, ubiquiti, 802.11, wifi, wireless, cli, programming]
categories: [wireless, ubiquiti, programming, hardware, software, diy]
author: nteleky
description: "nTeleKy's demonstration of the amazing powers of an XM series radio from Ubiquiti; what Ubiquiti hardware used to be like and why it's awesome; programming the radios and interfacing with them via SSH and the linux/windows CLI; interference mitigation; much, much more! in this episode we take the deepest dive into the filesystem!
image: https://jackd.ethertech.org/images/mythic_support_small.png
---

# XM: The Filesystem

In unix, "everything is a file", unfortunately after Lennart Poettering everything is now an unreadable binary file on most distros - but **not this one**.

## What's in there?

Good question!  Sounds exhausting and impossible to look at *everything* in the filesystem, right?  Even troubleshooting a single program on Windows can take hours and might involve hidden, unmanageable files in the case of 'Apps'.  What if I told you it was super easy and quick to get an overview of the *entire* filesystem?  I'm not going to, but imagine if I did.  To me, though, this is *fun*.  It's like going on an exploratory *exhibition*.  Here's where I started:

```
login as: ubnt
ubnt@192.168.11.20's password:


BusyBox v1.11.2 (2013-05-28 17:52:06 EEST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

XM.v5.5.6# find
.
./dropbear_rsa_host_key
./dropbear_dss_host_key
XM.v5.5.6# ls
dropbear_dss_host_key  dropbear_rsa_host_key
XM.v5.5.6# pwd
/var/etc/persistent
XM.v5.5.6# cd /
XM.v5.5.6# find . | sed 's|[^/]*/|  |g' > /var/etc/persistent/file_tree.txt
XM.v5.5.6# vi /var/etc/persistent/file_tree.txt
```

I'll admit I had help - Lupa gave me that `sed` trick, but that's just formatting.  I'd have liked to use tree, but it's not installed.  Now let's take a quick look at the hardware:

```
XM.v5.5.6# `cat /proc/cpuinfo`
system type             : Atheros AR7240 (Python)
processor               : 0
cpu model               : MIPS 24Kc V7.4
BogoMIPS                : 259.58
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 16
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, address/irw mask: [0x0ff8, 0x0fcc, 0x0e                                                                                                                                                             b8, 0x0e78]
ASEs implemented        : mips16
shadow register sets    : 1
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

XM.v5.5.6# `cat /proc/meminfo`
**MemTotal:          62012 kB**
**MemFree:           46912 kB**
Buffers:             756 kB
Cached:             3248 kB
SwapCached:            0 kB
Active:             2416 kB
Inactive:           2544 kB
Active(anon):       1232 kB
Inactive(anon):       68 kB
Active(file):       1184 kB
Inactive(file):     2476 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:           972 kB
Mapped:             1940 kB
Shmem:               344 kB
Slab:               6384 kB
SReclaimable:       2668 kB
SUnreclaim:         3716 kB
KernelStack:         184 kB
PageTables:          156 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       31004 kB
Committed_AS:       2860 kB
VmallocTotal:    1048372 kB
VmallocUsed:         620 kB
VmallocChunk:    1040004 kB
XM.v5.5.6# `cat /proc/mounts`
rootfs / rootfs rw 0 0
**/dev/root / squashfs ro,relatime 0 0**
none /proc proc rw,relatime 0 0
none /sys sysfs rw,relatime 0 0
tmpfs /var tmpfs rw,relatime,size=9216k 0 0
**dev /dev tmpfs rw,relatime 0 0**
none /dev/pts devpts rw,relatime,mode=600 0 0
none /proc/bus/usb usbfs rw,relatime 0 0
XM.v5.5.6# `cat /proc/version`
**Linux version 2.6.32.54 (buildd@builder) (gcc version 4.1.2) #1 Tue May 28 17:56:11 EEST 2013**
XM.v5.5.6# `df -h`
Filesystem                Size      Used Available Use% Mounted on
rootfs                  **5.3M**    5.3M         0 100% /
/dev/root                 5.3M      5.3M         0 100% /
tmpfs                     9.0M    352.0k      8.7M   4% /var
dev                    **30.3M**       0     30.3M   0% /dev
XM.v5.5.6# blkid
-sh: blkid: not found
XM.v5.5.6# lsblk -f
-sh: lsblk: not found
```

A couple notes - **64MiB RAM** and 2/3 of it is *free*.  This is efficiency, but it comes at a cost - some common programs like `blkid` or `lsblk` are missing.  I actually like the challenge of finding ways to achieve results using the minimal system, though.

Oh, it uses an old encryption protocol, so you'll get this error: ``.  You can (wreckommended) enable it per session, but I'm really not worried about a slightly insecure protocol on a local network to a limited context, A/K/A *living dangerously* and don't have the time for it so I edit `.ssh/config` and add:

```
Host ubnt-radio
    HostName 192.168.11.20
    KexAlgorithms +diffie-hellman-group1-sha1
    HostKeyAlgorithms +ssh-rsa
    Ciphers +aes128-cbc
    User ubnt
```

###  Oh shit, how am I gonna get that file, though?

FTP? SCP? SMB? NFS? ***cat***

```
$ ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-rsa -oCiphers=+aes128-cbc ubnt@192.168.11.20 'cat /var/etc/persistent/file_tree.txt' > file_tree.txt
ubnt@192.168.11.20's password:
```

**BINGO**, it's there.  If you want to send a file?

```
User@DESKTOP-MBVDS8A MINGW64 ~/Desktop/ubiquiti
$ cat desktop.ini | ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-rsa -oCiphers=+aes128-cbc ubnt@192.168.11.20 'cat > /var/etc/persistent/antenna.pdf'
ubnt@192.168.11.20's password:

User@DESKTOP-MBVDS8A MINGW64 ~/Desktop/ubiquiti
$ ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-rsa -oCiphers=+aes128-cbc ubnt@192.168.11.20 'ls /var/etc/persistent/'
ubnt@192.168.11.20's password:
antenna.pdf
dropbear_dss_host_key
dropbear_rsa_host_key
file_tree.txt
file_tree.txtlogin
$ ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-rsa -oCiphers=+aes128-cbc ubnt@192.168.11.20 'cat /var/etc/persistent/antenna.pdf'
ubnt@192.168.11.20's password:
[LocalizedFileNames]
ubnt-discovery(1).zip=@ubnt-discovery(1),0


```

You'll just have to trust me that's the proper contents of `desktop.ini`, mysteriously saved as `antenna.pdf` *intentionally*... ;-)

*Make sure to run cfgmtd -w -p /etc/ or similar afterward **to persist the file** across reboots if you're writing to /etc/persistent/*