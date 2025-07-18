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

### /bin - a primer

We're going to start where I started in this article and then jump to the deeper dive.  One of the first things I did was `ls -al /bin` to see what I had and didn't have.  Some things like `lspci`, for instance were notably lacking, but there are some goodies in there, too.

```
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 80211debug -> athbox
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 80211stats -> athbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 [ -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 [[ -> busybox
-rwxr-xr-x    1 ubnt     admin        4448 May 28 14:52 adjtimex
-rwxr-xr-x    1 ubnt     admin        8645 May 28 14:43 airview
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 arping -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ash -> busybox
-rwxr-xr-x    1 ubnt     admin      129204 May 28 14:53 athbox
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 athchans -> athbox
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 athdebug -> athbox
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 athkey -> athbox
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 athstats -> athbox
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 athstatsclr -> athbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 awk -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 basename -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 bgnd -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 brctl -> busybox
-rwxr-xr-x    1 ubnt     admin         532 May 28 14:43 brmacs
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 bunzip2 -> busybox
-rwxr-xr-x    1 ubnt     admin      538664 May 28 14:54 busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 bzcat -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 cat -> busybox
-rwxr-xr-x    1 ubnt     admin         968 May 28 14:43 ccode.sh
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 cfgmtd -> ubntbox
-rwxr-xr-x    1 ubnt     admin      259859 May 28 14:52 cgi
-rwxr-xr-x    1 ubnt     admin       21788 May 28 14:55 chat
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 chgrp -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 chmod -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 chown -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 chroot -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 clear -> busybox
-rwxr-xr-x    1 ubnt     admin          66 May 28 14:43 counterfeit
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 cp -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 crond -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 crontab -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 cut -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 date -> busybox
lrwxrwxrwx    1 ubnt     admin          16 May 28 14:52 dbclient -> ../sbin/drop                                                                                                                                                             bear
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 dd -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 df -> busybox
-rwxr-xr-x    1 ubnt     admin       28228 May 28 14:52 dhcp-fwd
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 diff -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 dirname -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 discover -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 dmesg -> busybox
-rwxr-xr-x    1 ubnt     admin      157292 May 28 14:52 dnsmasq
-rwxr-xr-x    1 ubnt     admin      225396 May 28 14:52 dropbear
lrwxrwxrwx    1 ubnt     admin          16 May 28 14:52 dropbearkey -> ../sbin/d                                                                                                                                                             ropbear
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 du -> busybox
-rwxr-xr-x    1 ubnt     admin        3084 May 28 14:52 ebtables
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 echo -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 egrep -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 env -> busybox
-rwxr-xr-x    1 ubnt     admin      117776 May 28 14:52 ethtool
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 expr -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 factorytest -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 false -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 fgrep -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 find -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 free -> busybox
-rwxr-xr-x    1 ubnt     admin       19192 May 28 14:52 fusermount
-rwxr-xr-x    1 ubnt     admin         686 May 28 14:54 fwupdate
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 fwupdate.real -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 garp -> busybox
-rwxr-xr-x    1 ubnt     admin       49024 May 28 14:52 gcom
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 getty -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 grep -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 gunzip -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 gzip -> busybox
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 haldebug -> athbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 halt -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 head -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 hexdump -> busybox
-rwxr-xr-x    1 ubnt     admin      297456 May 28 14:52 hostapd
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 hostid -> busybox
-rwxr-xr-x    1 ubnt     admin         155 May 28 14:43 hotplug-call
-rwxr-xr-x    1 ubnt     admin       29628 May 28 14:52 hotplug2
-rwxr-xr-x    1 ubnt     admin        7924 May 28 14:43 htb
-rwxr-xr-x    1 ubnt     admin          46 May 28 14:43 http_enable
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 hwclock -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 id -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ifconfig -> busybox
-rwxr-xr-x    1 ubnt     admin       33784 May 28 14:52 igmpproxy
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 infctld -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 init -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 insmod -> busybox
-rwxr-xr-x    1 ubnt     admin      195748 May 28 14:52 ip
-rwxr-xr-x    1 ubnt     admin       55352 May 28 14:54 ip6tables
-rwxr-xr-x    1 ubnt     admin       96100 May 28 14:52 iperf
-rwxr-xr-x    1 ubnt     admin       55316 May 28 14:54 iptables
-rwxr-xr-x    1 ubnt     admin       84472 May 28 14:52 iwconfig
lrwxrwxrwx    1 ubnt     admin           8 May 28 14:52 iwevent -> iwconfig
lrwxrwxrwx    1 ubnt     admin           8 May 28 14:52 iwgetid -> iwconfig
lrwxrwxrwx    1 ubnt     admin           8 May 28 14:52 iwlist -> iwconfig
lrwxrwxrwx    1 ubnt     admin           8 May 28 14:52 iwpriv -> iwconfig
lrwxrwxrwx    1 ubnt     admin           8 May 28 14:52 iwspy -> iwconfig
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 kill -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 killall -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 killall5 -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 klogd -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 length -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 less -> busybox
-rwxr-xr-x    1 ubnt     admin      210972 May 28 14:54 lighttpd
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ln -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 lock -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 logger -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 login -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 logread -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ls -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 lsmod -> busybox
-rwxr-xr-x    1 ubnt     admin        7520 May 28 14:52 ma-auth
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:52 ma-check -> ma-auth
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:52 ma-deauth -> ma-auth
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:52 ma-rm -> ma-auth
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:52 ma-show -> ma-auth
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:52 ma-ticket-add -> ma-auth
-rwxr-xr-x    1 ubnt     admin        1346 May 28 14:54 mca-config
lrwxrwxrwx    1 ubnt     admin           4 May 28 14:54 mca-ctrl -> mcad
-rwxr-xr-x    1 ubnt     admin        1025 May 28 14:54 mca-fwupdate
-rwxr-xr-x    1 ubnt     admin        4122 May 28 14:54 mca-provision
lrwxrwxrwx    1 ubnt     admin          13 May 28 14:54 mca-provision-list -> mc                                                                                                                                                             a-provision
lrwxrwxrwx    1 ubnt     admin          13 May 28 14:54 mca-provision-rm -> mca-                                                                                                                                                             provision
lrwxrwxrwx    1 ubnt     admin          13 May 28 14:54 mca-startup -> mca-provi                                                                                                                                                             sion
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 mca-status -> ubntbox
-rwxr-xr-x    1 ubnt     admin        1047 May 28 14:54 mca-ticket
-rwxr-xr-x    1 ubnt     admin       63588 May 28 14:54 mcad
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 md5sum -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 mesg -> busybox
-rwxr-xr-x    1 ubnt     admin       85048 May 28 14:52 miniupnpd
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 mkdir -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 mkfifo -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 mknod -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 mktemp -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 mount -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 mv -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 netmsg -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 netstat -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 nice -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 nslookup -> busybox
-rwxr-xr-x    1 ubnt     admin       16728 May 28 14:52 ntpclient
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 passwd -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 pgrep -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 pidof -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ping -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ping6 -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 pivot_root -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 pkill -> busybox
-rwxr-xr-x    1 ubnt     admin        1583 May 28 14:43 pktgen.sh
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 poweroff -> busybox
-rwxr-xr-x    1 ubnt     admin      289544 May 28 14:55 pppd
-rwxr-xr-x    1 ubnt     admin       11652 May 28 14:55 pppstats
-rwxr-xr-x    1 ubnt     admin       87912 May 28 14:52 pptp
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 printf -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ps -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 pwd -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 pwdog -> busybox
-rwxr-xr-x    1 ubnt     admin        2328 May 28 14:43 radarmon
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 radartool -> athbox
-rwxr-xr-x    1 ubnt     admin          69 May 28 14:43 radartoolw
-rwxr-xr-x    1 ubnt     admin       84404 May 28 14:52 radvd
-rwxr-xr-x    1 ubnt     admin       15484 May 28 14:52 radvdump
-rwxr-xr-x    1 ubnt     admin         666 May 28 14:52 rate.awk
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 rdate -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 realpath -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 reboot -> busybox
-rwxr-xr-x    1 ubnt     admin      109576 May 28 14:53 regdomain
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 reset -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 rm -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 rmdir -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 rmmod -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 route -> busybox
-rwxr-xr-x    1 ubnt     admin       20212 May 28 14:54 rssi_decode
lrwxrwxrwx    1 ubnt     admin          19 May 28 14:54 scanparser -> /usr/www/s                                                                                                                                                             tatus.cgi
lrwxrwxrwx    1 ubnt     admin          16 May 28 14:52 scp -> ../sbin/dropbear
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 sed -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 seq -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 sh -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 sleep -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 sort -> busybox
-rwxr-xr-x    1 ubnt     admin      316128 May 28 14:55 spectralbox
lrwxrwxrwx    1 ubnt     admin          11 May 28 14:55 spectralplayer -> spectr                                                                                                                                                             albox
lrwxrwxrwx    1 ubnt     admin          11 May 28 14:55 spectralserver -> spectr                                                                                                                                                             albox
lrwxrwxrwx    1 ubnt     admin          11 May 28 14:55 spectraltool -> spectral                                                                                                                                                             box
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 speedicmp -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 speedsrv -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 speedtest -> ubntbox
lrwxrwxrwx    1 ubnt     admin          16 May 28 14:52 ssh -> ../sbin/dropbear
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 start-stop-daemon -> bus                                                                                                                                                             ybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 status-full.cgi -> ubntb                                                                                                                                                             ox
-rwxr-xr-x    1 ubnt     admin       24468 May 28 14:52 stress
-rwxr-xr-x    1 ubnt     admin        3074 May 28 14:43 support
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 switch_root -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 sync -> busybox
-rwxr-xr-x    1 ubnt     admin         623 May 28 14:43 syscheck
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 sysctl -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 sysled -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 syslogd -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 tail -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 tar -> busybox
-rwxr-xr-x    1 ubnt     admin      230776 May 28 14:52 tc
-rwxr-xr-x    1 ubnt     admin      601032 May 28 14:52 tcpdump
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 tee -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 telnet -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 telnetd -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 test -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 tftp -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 time -> busybox
-rwxr-xr-x    1 ubnt     admin       39568 May 28 14:55 tinysnmpd
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 top -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 touch -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 tr -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 traceroute -> busybox
lrwxrwxrwx    1 ubnt     admin          19 May 28 14:54 trigger_url -> /usr/www/                                                                                                                                                             status.cgi
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 true -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ubnt-caldata -> ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ubnt-gps-reader -> ubntb                                                                                                                                                             ox
-rwxr-xr-x    1 ubnt     admin     1332584 May 28 14:54 ubntbox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 ubntconf -> ubntbox
-rwxr-xr-x    1 ubnt     admin       21931 May 28 14:52 udevtrigger
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 udhcpc -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 umount -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 uname -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 uniq -> busybox
-rwxr-xr-x    1 ubnt     admin       18915 May 28 14:43 updatefix.sh
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 uptime -> busybox
-rwxr-xr-x    1 ubnt     admin       38028 May 28 14:52 usb_modeswitch
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 uudecode -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 uuencode -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 vconfig -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 vi -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 watchdog -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 wc -> busybox
lrwxrwxrwx    1 ubnt     admin          19 May 28 14:54 webping -> /usr/www/stat                                                                                                                                                             us.cgi
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 wget -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 which -> busybox
lrwxrwxrwx    1 ubnt     admin           6 May 28 14:53 wlanconfig -> athbox
-rwxr-xr-x    1 ubnt     admin      414736 May 28 14:53 wpa_supplicant
lrwxrwxrwx    1 ubnt     admin          19 May 28 14:54 wstalist -> /usr/www/sta                                                                                                                                                             tus.cgi
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 xargs -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 yes -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 zcat -> busybox
lrwxrwxrwx    1 ubnt     admin           7 May 28 14:54 zcip -> busybox
```


Right at the top we have `80211debug` and `80211stats`, which sound interesting and are symlinks to `athbox`, we see a bunch more `ath` utilities and remember we have an `ath`eros chipset, so that's a good place to start.

```
XM.v5.5.6# 80211debug
net.ath0.debug: 0x0
XM.v5.5.6# 80211stats
1117 rx discard mgt frames
816 rx required element missing
1438141 rx element unknown
11257 active scans started
```
OK, not much and kind of interesting.  `athstats` will give you general statistics on your baseband chipset, which can be really helpful.  The output will change depending on the mode and characteristics, whether it's in `AP` or `client`, etc.  You can see our base utilities are `athbox`, `busybox`, `mca-provision` and `ubntbox`.  If you don't know what [busybox](https://busybox.net/) is, [this is a good time to learn](https://en.wikipedia.org/wiki/BusyBox).  Basically, it's a bunch of common linux utilities, minimized and put in a single executable, often used on embedded linux systems.  From this, you can gather that `ubntbox` and `athbox` are similar utilities for management of the atheros chipset and the ubiquiti utilities.  You can read a little bit on `mca-provision` [here](https://community.ui.com/questions/Custom-use-of-mca-provision/8421ed78-6003-4388-abe0-700c3708a673).

```
XM.v5.5.6# athbox
Usage: athbox <tool>
 Supported tools:
        wlanconfig
        athstats
        athstatsclr
        80211stats
        athkey
        radartool
        80211debug
        athdebug
        haldebug
        athchans
XM.v5.5.6# ubntbox
Ubiquiti system tools colection
Copyright 2006-2013, Ubiquiti Networks, Inc. <support@ubnt.com>

This program is proprietary software; you can not redistribute it and/or modify
it without signed agreement with Ubiquiti Networks, Inc.

        ubntconf
        cfgmtd
        fwupdate.real
        speedtest
        speedsrv
        speedicmp
        infctld
        factorytest
        sysled
        bgnd
        mca-status
        discover
        status-full.cgi
        status-new.cgi
        ifstats.cgi
        iflist.cgi
        scan.cgi
        ubnt-gps-reader
        ubnt-caldata
        dfs-unlock
XM.v5.5.6# mca-provision
Usage: /usr/bin/mca-provision <consoleurl> <ssh-public-key> [<id> [<comment>]]
XM.v5.5.6# busybox
BusyBox v1.11.2 (2013-05-28 17:52:06 EEST) multi-call binary
Copyright (C) 1998-2008 Erik Andersen, Rob Landley, Denys Vlasenko
and others. Licensed under GPLv2.
See source distribution for full notice.

Usage: busybox [function] [arguments]...
   or: function [arguments]...

        BusyBox is a multi-call binary that combines many common Unix
        utilities into a single executable.  Most people will create a
        link to busybox for each function they wish to use and BusyBox
        will act like whatever it was invoked as!

Currently defined functions:
        [, [[, adjtimex, arping, ash, awk, basename, brctl, bunzip2, bzcat, cat, chgrp, chmod, chown, chroot, clear, cp, crond, crontab, cut, date, dd, df, diff, dirname, dmesg, du, echo, egrep, env, expr, false, fgrep, find,
        free, garp, getty, grep, gunzip, gzip, halt, head, hexdump, hostid, hwclock, id, ifconfig, init, insmod, kill, killall, killall5, klogd, length, less, ln, lock, logger, login, logread, ls, lsmod, md5sum, mesg, mkdir,
        mkfifo, mknod, mktemp, mount, mv, netmsg, netstat, nice, nslookup, passwd, pgrep, pidof, ping, ping6, pivot_root, pkill, poweroff, printf, ps, pwd, pwdog, rdate, realpath, reboot, reset, rm, rmdir, rmmod, route, sed,
        seq, sh, sleep, sort, start-stop-daemon, switch_root, sync, sysctl, syslogd, tail, tar, tee, telnet, telnetd, test, tftp, time, top, touch, tr, traceroute, true, udhcpc, umount, uname, uniq, uptime, uudecode, uuencode,
        vconfig, vi, watchdog, wc, wget, which, xargs, yes, zcat, zcip

```

OK, that's as far as we're going to go in this article, I'm trying to keep these to about a day's worth of content each, although some may be a bit longer.  Hope you're enjoying this exploratory adventure as much as I am and have a great day!