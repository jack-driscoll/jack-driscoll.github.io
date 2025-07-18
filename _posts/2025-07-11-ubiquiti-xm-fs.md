---
layout: post
title: "The Ubiquiti XM Filestysem: A Definitive Guide by nTeleKy"
date: 2025-07-11
permalink: /2025-07-11-ubiquiti-xm-fs.html
tags: [article, internet, embedded, ubiquiti, 802.11, wifi, wireless, cli, programming]
categories: [wireless, ubiquiti, programming, hardware, software, diy]
author: nteleky
description: "nTeleKy's demonstration of the amazing powers of an XM series radio from Ubiquiti; what Ubiquiti hardware used to be like and why it's awesome; programming the radios and interfacing with them via SSH and the linux/windows CLI; interference mitigation; much, much more! in this episode we take the deepest dive into the filesystem!"
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

### The Filesystem

Check out the directories, which (will) link to a full breakdown of each one; the symlinks go to their sources, just like IRL.  Thank Lupa for this, and the beatiful complete file tree!  Isn't it gorgeous?  That's right, it's not a picture, go ahead and hover on those babys!

<pre style="background: #000; color: white; padding: 1em; font-family: monospace; font-size: 0.95em;">
drwxr-xr-x   11 ubnt     admin         186 May 28 14:56 .
drwxr-xr-x   11 ubnt     admin         186 May 28 14:56 ..
drwxr-xr-x    2 ubnt     admin        3550 May 28 14:53 <a href="/2025-07-12-ubiquiti-xm-fsc.html#bin" style="color: orchid;" title="Not a screenshot, this baby’s live">bin</a>
drwxrwxrwt    4 ubnt     admin        2420 May 28 17:55 <a href="/2025-07-12-ubiquiti-xm-fsc.html#dev" style="color: orchid;" title="My gay werewolf friend helped me with this">dev</a>
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:55 <span style="color: deepskyblue;">etc</span> -> <a href="/2025-07-12-ubiquiti-xm-fsc.html#var-etc" style="color: orchid;" title="realistically, I would have given up">var/etc</a>
-rwxr-xr-x    1 ubnt     admin        4665 May 28 14:55 <a href="/2025-07-12-ubiquiti-xm-fsc.html#init" style="color: limegreen;" title="looks slick as shit, hey?">init</a>
drwxr-xr-x    2 ubnt     admin           3 May 28 14:56 <a href="/2025-07-12-ubiquiti-xm-fsc.html#jffs" style="color: orchid;" title="there's a different hidden message in each one, too">jffs</a>
drwxr-xr-x   11 ubnt     admin        1248 May 28 14:55 <a href="/2025-07-12-ubiquiti-xm-fsc.html#lib" style="color: orchid;" title="u even hhave easer eggs, bruh?">lib</a>
drwxr-xr-x    2 ubnt     admin           3 May 28 14:52 <a href="/2025-07-12-ubiquiti-xm-fsc.html#mnt" style="color: orchid;" title="yeah, I actually typed these in here">mnt</a>
dr-xr-xr-x   33 ubnt     admin           0 Jan  1  1970 <a href="/2025-07-12-ubiquiti-xm-fsc.html#proc" style="color: orchid;" title="oh, and I got the filesystem layout">proc</a>
lrwxrwxrwx    1 ubnt     admin           3 May 28 14:55 <span style="color: deepskyblue;">sbin</span> -> <a href="/2025-07-12-ubiquiti-xm-fsc.html#sbin" style="color: orchid;" title="but I couldn't have done it without Lupa">bin</a>
drwxr-xr-x   11 ubnt     admin           0 Jan  1  1970 <a href="/2025-07-12-ubiquiti-xm-fsc.html#sys" style="color: orchid;" title="OK, maybe I could have, but it would have taken a really long time, for me">sys</a>
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:55 <span style="color: deepskyblue;">tmp</span> -> <a href="/2025-07-12-ubiquiti-xm-fsc.html#var-tmp" style="color: orchid;" title="realistically, I would have given up">var/tmp</a>
drwxr-xr-x    5 ubnt     admin          96 May 28 14:55 <a href="/2025-07-12-ubiquiti-xm-fsc.html#usr" style="color: orchid;" title="instead, we got this done in like 30 minutes, actually less">usr</a>
drwxrwxrwt    7 ubnt     admin         140 Jan  1  1970 <a href="/2025-07-12-ubiquiti-xm-fsc.html#var" style="color: orchid;" title="and that includes all this unnecessary fun">var</a>
</pre>

## What are the directories *used for*, though

Some of you are probably familiar with this directory layout from your experience(s) with linux; even then, however, it can be a little confusing.  I've asked Lupa to put together a general description of the fs and what the folders are used for:

| Path | Description |
| `/bin/` | Core system binaries (BusyBox, shell, minimal user tools) |
| `/sbin/` → `/bin/` | Symlink to core system binaries (admin tools, mount, etc.) |
| `/etc/` → `/var/etc/` | Configuration files (persistent if saved with `cfgmtd`) |
| `/lib/` | Shared libraries and kernel modules |
| `/usr/` | Additional binaries and read-only user-space |
| `/var/` | Writable area with logs, configs, temp files |
| `/var/tmp/` | Temp storage (symlink from `/tmp`) |
| `/var/etc/` | Active config, including `dropbear` keys, saved settings |
| `/proc/` | Virtual kernel info (mem, cpu, mounts, irq, etc.) |
| `/sys/` | Exposes kernel device/driver data |
| `/mnt/` | Mount point for external devices (not always used) |
| `/jffs/` | Writable flash memory partition, may not be mounted |
| `/dev/` | Device nodes for tty, eth0, etc. |
| `/init` | Init script (first executed during boot) |
| --- | --- |