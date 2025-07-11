---
layout: post
title: "The Ubiquiti XM Radio To Rule Them All by nTeleKy"
date: 2025-07-11
permalink: /2025-07-11-ubiquiti-xm.html
tags: [article, internet, embedded, ubiquiti, 802.11, wifi, wireless, cli, programming]
categories: [wireless, ubiquiti, programming, hardware, software, diy]
author: nteleky
description: "nTeleKy's demonstration of the amazing powers of an XM series radio from Ubiquiti; what Ubiquiti hardware used to be like and why it's awesome; programming the radios and interfacing with them via SSH and the linux/windows CLI; interference mitigation; why Spectrum sucks donkey balls [no offense to donkeys]; much, much more! 802.11 wireless deep dive, spectrum/spectral analysis, athstats, atheros chipsets, linux embedded hardware ath9k"
image: https://jackd.ethertech.org/images/mythic_support_small.png
---

***Work in Progress as of 2025/07/11***

# Ubiquiti XM and XW Devices and the 802.11 PHY layer

Hi, today we're going to take a look at the Ubiquiti XM and XW devices and play with a rare bird from the collection.  My personal collection was thrown away when I ended up in jail in 2024 and I'm trying to revive it; [see here if you have equipment you might consider donating](https://jackd.ethertech.org/2025-07-01-wisp-2.html#hw-request).

[References](#references) are at the bottom.  GH Pages doesn't support footnotes in markdown.

Tektronix has an excellent guide to the physical layer of `802.11` that will be referenced repeatedly.  If you aren't familiar with the physical layer, you may want to read this first.

## Ubiquiti Rocket M 5.8 GHz International

The Ubiquiti Rocket devices are 5.8GHz 802.11 a/b/g/n, although Ubiquiti offers modifications of the standard 802.11 protocol known as AirView.  They come with two reverse-SMA connectors so they can be mounted to a variety of antennas.  While they don't support AC, they can still push a surprising amount of bandwidth, as we'll see later.  We typically used these for APs, but also backhaul with some larger parabolic dishes (up to around 3 ft and 34dBi).

### AirView - What is it?

## Getting started

I put together a repository for the software and firmware used in this post.  It's all available on Ubiquiti's website, with the exception of some of the firmware, which I found on third-party sites and scanned for virii.  The last time virustotal saw the firmware was *2 years ago*!  We'll change the firmware, factory default the device and then start exploring it.  In later posts, we're going to write our own python utilities to automate management, get information, and possibly explore some in-depth hardware exploration like serial console and USB host (some, but not all of the Rockets support this).

### Finding the device

The devices are "discovered" via layer-2 MAC queries using `ubnt-discovery`, the Ubiquiti Discovery Tool.  Unfortunately they only seem to have the newer v6 tool and I get a java exception when trying to run it.  You'll need an old version of java to support these utilities, I'm using `jre1.8.0_451`.

![ubiquiti discovery tool](/images/ubiquiti/network_connection_ds_3.png)

![java exception from ubiquiti discovery tool](/images/ubiquiti/network_connection_ds_4.png)

There are some 3rd party tools available now that I thought I'd try because I don't like java anyway.
- [This C# one looks nice](https://github.com/SilverCard/UbntDiscovery), but didn't detect my radio
- [python-ubnt-discovery](https://github.com/nitefood/python-ubnt-discovery) threw an exception
- [ubnt-discover.py](https://github.com/just-oblivious/python-ubiquiti-discover) timed out
- [ubnt-discover](https://github.com/guerrerocarlos/ubnt-discover) is javascript !?
- [ubnt-discovery-tool](https://github.com/MatrixEditor/ubnt-discovery-tool) is another java implementation

The first one, the C# implementation, didn't discover any devices and when I look with WireShark doesn't seem to do anything.

![C# ubiquiti discovery tool shows no devices](/images/network_connection_ds_5.png)

The second one I tried, `python-ubnt-discovery`, threw an exception

![python ubiquiti discovery tool throws exception](/images/network_connection_ds_6.png)

The next one, `ubnt-discover.py`, timed out.

![python ubiquiti discovery tool times out](/images/network_connection_ds_7.png)

The next one, written in javascript, known for its low-level networking capabilities (right?) actually worked, so who am I to say "why would you use javascript for this?".

![finally the javascript version finds it](/images/network_connection_ds_8.png)

OK, so we have our radio at the default address of `192.168.1.20` and it's got a nice CLI interface and even shows us the firmware version, which is unfortunately `XM.ar7240.v5.5.10.24241.141001.1649`.  Why unfortunately?  Because these radios, ending with **5.5.6**, could access all the frequencies of all the countries.  Not necessarily necessary, but could be useful.  In any case, let's see if we can log into the radio with the default **ubnt/ubnt**.

### Logging In

I can't even log into the web interface, because this version of FireFox won't support this version of **TLS**.

![nuh-uh, no radio for you, says the fire fox](/images/ubiquiti/network_connection_ff_9.png)

The first two guides, one said to set tls.version.max to 3 instead of 4, and the other said to set min to 3, which it was already at.  Those recommendations both 1) didn't make any sense (why would changing the max version to something lower help?) and 2) didn't work.  So I changed it to **1** instead, because you would want it to support a lower version (2, actually, right?) and it worked!

![change the settings](/images/ubiquiti/network_connection_ff_10.png) **WRONG**

![change the settings](/images/ubiquiti/network_connection_ff_10_2.png) **RIGHT**

You might go to security hell for supporting low versions of **TLS**, but it's a risk I'm willing to take.

![sure, why not, says the fire fox](/images/ubiquiti/network_connection_ff_11.png)

![the web interface of the Rocket M](/images/ubiquiti/network_connection_ff_12.png)

Hey, a familiar face at last!  I managed to find this particular version online, so we don't have to worry about extracting the `*.bin` file (which I can assure you *is* possible).  Why?  Some of these firmwares are hard to find now!  Ubiquiti doesn't have a very clear way to download their old firmwares, even the ones they do still host.  For some reason, 5.5.6 is mysteriously missing, probably **F**anny's **C**upcake **C**atering gave them a hard time about it.  I'm not even going to tell you what I had to do to get **v5.5.6build17762**, but I had to take a hot shower afterward.

### Downgrading The Firmware

!["upgrading" the firmware](/images/ubiquiti/fw_update_1.png)

!["upgrading" the firmware](/images/ubiquiti/fw_update_2.png)

This is build **5.5.6v17762** and the country code is already set.  I'm going to try factory defaulting it.

Yes!  This is what I wanted to see.  I recently moved to the unregulated territories of **Compliance Test**, so I'm going to set it to that.

!["upgrading" the firmware](/images/ubiquiti/fw_update_3.png)

### Look Around You ,.-*

#### Site Survey

Let's take a look at our network neighborhood.  First off, Holy Shit!, I thought these guys had an expanded range, but ***wow***.  Secondly, Holy Shit!, I must be living in the boondocks because I only have **4** 5.8 networks visible!

!["upgrading" the firmware](/images/ubiquiti/fw_update_4.png)

#### AirView - Getting Started

One of the coolest thing about the XM and XW series devices was their Spectrum Analyzer.  Unlike later devices, which had **2 radios** in them to support constant spectral awareness, these radios have to be taken *out of service* to do an **AirView**, which is the built-in Spectrum Analyzer.  The advantage of a spectrum analysis is that you can see *any* transmission in the specified range, not only supported wireless 802.11.  This is super important for detecting interference and **link budgeting** (finding clear spectra and deciding where to place links and what channel/spectral width to use).

Unfortunately, Java, like FireFox doesn't like our ancient security protocol.

![danger, Will Robinson, TLS version too antiquated](/images/ubiquiti/airview_1.png)

So ask your resident know-it-all-werewolf, Lupa, what to do...

---
---

Ah yes — the classic **Java + AirView JNLP app + deprecated TLS** pain combo. You're seeing:

```
javax.net.ssl.SSLHandshakeException:
The server selected protocol version TLS10 is not accepted by client preferences [TLS13, TLS12]
```

This means:

* Your **Rocket M5/AirView server is using TLS 1.0**, an ancient protocol.
* Your **modern Java version has TLS 1.0 disabled by default.**
* The client refuses to talk to it, so the `.jnlp` Java Web Start app crashes.

---

### ✅ FIX: Re-enable TLS 1.0 and TLS 1.1 in your Java config

You can do this by editing the Java security config file:

#### 🛠 Step-by-step:

1. **Locate your Java security file**
   Usually here:

   ```
   C:\Program Files\Java\jre1.8.0_xx\lib\security\java.security
   ```

2. **Edit `java.security` with admin privileges**
   Open it in a text editor (e.g., Notepad++) as Administrator.

3. **Find the line** (usually around line 100):

   ```properties
   jdk.tls.disabledAlgorithms=SSLv3, TLSv1, TLSv1.1, ...
   ```

4. **Remove `TLSv1` and/or `TLSv1.1`**
   Modify it like this:

   ```properties
   jdk.tls.disabledAlgorithms=SSLv3
   ```

   *(You can leave out `TLSv1.1` if you're still being blocked, but usually removing TLSv1 is enough.)*

5. **Save the file.**

6. **Restart your browser or Java Web Start.**

---

### ☢️ ⚠️ WARNING:

This is **insecure** and should only be done in a **controlled LAN environment** (which this is). Do **not** re-enable TLS 1.0 globally if you're using Java for anything that talks to the public internet.

If you want to undo it later, just re-add `TLSv1` to the disabled list.

---

### 🧼 Bonus Cleanup:

Java Web Start is deprecated in modern JDKs. If you're running into issues launching `.jnlp`:

* Install an older JRE (like **Java 8u181**) which still supports Web Start.
* Or use **IcedTea-Web** (OpenJDK-compatible) as a fallback.

---

Once you're in, **AirView** will give you that sweet **real-time waterfall** over your 1GHz slice. Let me know if you want help scripting AirView captures or auto-logging spectral noise over time.

![my gay werewolf friend told me to change this file](/images/ubiquiti/airview_2.png)

Well, that wasn't enough.  I had to go into Java Configuration and enable them

![my gay werewolf friend told me to change this file](/images/ubiquiti/airview_3.png)

![my gay weredeer friend told me to change this file](/images/ubiquiti/airview_4.png)

Say to ignore these warnings

![say yes to this](/images/ubiquiti/airview_5.png)

![yes AND](/images/ubiquiti/airview_6.png)

---
---

#### Airview: We're In!

We're in!  I wonder if it'll let me look at the whole thing?  Let's go to preferences and put in a custom range of 4900-6300.  Well it only goes up to 6100, looks like, but hey - it does!

![woot, we're in](/images/ubiquiti/airview_7.png)

Aight, cool.  Looks like there's some overlap here, [let's take a look at our router](#my-network), which is probably autoconfigured (which only works ~50% of the time).

I let it run for a while, as it's scanning across the frequencies and the device may not be transmitting at the exact second it samples, you need to let it run for a bit to get a good view; the wider the bandwidth, the longer the run.  Here it as after 90 minutes.

![a 90 minute full-spectrum scan](/images/ubiquiti/airview_8.png)

Let's take a look at our more coherent AirView from 5750-5850  

![5750-5850MHz AirView](/images/ubiquiti/airview_9.png)

I'm guessing we have a 40MHz at 5770, a 20MHz at 5780 and then it gets kind of hard to read.  They'll always extend out slightly past their actual bandwidth - it looks like a plateau with little angles toward the bottom (depending on the technology used).[^1]  I'm going to wait for it to come back (change out of Spectrum Analyzer mode) and then check to see what's visible again.  Right now, we're in **auto 20/40MHz**, so we can see both 20 and 40 MHz networks by SSID, but not 10 or 80 MHz networks (or any of the other weird channel widths ubiquiti offers; obviously we can see their emissions in the Spectrum Analyzer, though).  Let's take a look:

![5785 and 5220 center channels](/images/ubiquiti/site_survey_1.png)

Well, I was wrong, we've got a 5220MHz (not visible on the spectrum analyzer due to constrained bandwidth) @ **-85/95dBm** and our network (5785) at **-48/93dBm**.  This gives us an `SNR` of 45dBm, which is [really good actually](https://d2cpnw0u24fjm4.cloudfront.net/wp-content/uploads/802.11n-and-802.11ac-MCS-SNR-and-RSSI.pdf).  If you look at the AirView, though, you can clearly see the real noise floor looks more like **-75dBm**, although those transmissions are less frequent.  Why is this?  I'd guess there's two other networks on **80MHz** channels.  Unfortunately this is not an `802.11ac` radio, so I can't scan for these using this router (which is why I'd be thrilled if you had any old hardware [even AC is old now] you could send me, because I'm *really poor*).  I'm hoping to get either a nanobeam AC or an LR AC so I can increase my visibility.  I'm also going to see what chipset my laptop has and if I can do anything with that.  The good thing is, the only two visible networks are not on top of each other, the bad thing is some of the invisible ones are.

## Establishing a Link

## We're Going In!

One of the best things about these is they're embedded linux and run busybox, so if you're already familiar with linux and busybox, you've got a leg up on the competition.  You can `SSH` into the radios and do a number of things, the most useful of which is `athstats`.

## Taking a Look at My Network {#my-network}

[^router] It's a WiFi6 router, but...well, let's just take a look.

Oh, cool, just what I needed - *another app*.  Criminy Jickets.  Well, I gave up fighting the "this is completely unnecessary, why do I need an app for this" battle a while ago, so I'll just *comply*.  Great, it wants a user name and password, not just the authentication information from the router and this isn't my personal account, it's a house account.  Let's check Spectrum's website, which is garbage and has no information on changing the WiFi channel.  OK, now let's [check reddit](https://www.reddit.com/r/Spectrum/comments/uxpn18/wifi_6_router_web_interface/) and it looks like we're probably SOL, you definitely need the app but it doesn't look like anyone's actually used the app to do anything advanced.  You also see a claim that anyone with over 20 WiFi devices needs a $100+ "gaming router".  I can assure you that you do not need to spend that much, but $50+ is reasonable if you get the right equipment.  You need enough CPU and RAM, say 400+MHz and 32-64MiB for starters, but most importantly *you need a clear channel* and it's obvious we don't have that.  You can also see that although this is called **WiFi 6** only **WiFi 6E** uses the '6GHz band' (5935-7115MHz), the rest of **WiFi 6** is actually extensions to `802.11ac`, `802.11ax`, like higher rates due to increased `QAM` (Quadrature Amplitude Modulation - how many bits per cycle) and `OFDMA` (Orthogonal Frequency Division Multiple Access - simultaneous low data-rate users and simplified Collision Avoidance, among other things).  None of this means **jack shit** if you have two devices sitting on top of each other, however.

I'll use this platform as another chance to pimp my service **brainspunk/'my genius'** by pointing out this **wildly wrong answer** [on the first page of google results](https://manuals.plus/qa/4785380/How-do-I-set-up-my-Spectrum-WiFi-6-Router).  No, you cannot log in to 192.168.1.1.  Yes, you need the app.  No, the username is not **printed on the side of the router** (unlike **every other sane manufacturer**), you need your account-related username and password, which, since I don't own the account, means: **I'm boned**.  I'll try to get it from the owner, who assuredly **does not have it** because no one ever saves this information, and will probably not want to look it up, because **it's a pain in the ass** so we're **just going to have to deal with excessive lag and an underperforming network** - sucks to be us.  What **I'm** going to do, though, as soon as I finish with this, is **plug in a damn cable**.  First, though, I'm going to do a couple speed tests.

![150ms of latency and 35Mbps down - awful](/images/ubiquiti/speed_test_1.jpg)

Just what I thought - **fucking awful**.  100+ms of latency is a crime.  I'm 5 feet from the router, too.  It also didn't give me my final scores, boo, "open speed test", boo.  Of course, the word 'open' in this means ***nothing***, as well, as it's neither open source, or open in any other regard.  OK, let's try google fiber's speed test.

![36ms of latency and 480Mbps down - wildly different results](/images/ubiquiti/speed_test_2.jpg)

This is why I use multiple services - here we have *wildly different results*.  This is actually not *too bad*, especially considering our misconfigured router.  The jitter, especially, is less than expected.

![38ms of latency and 460Mbps down](/images/ubiquiti/speed_test_3.jpg)

460/11 and 38ms, with no jitter (variability in ping) test results.  Also, the summary icons have nonsense numbers, for some reason (89/213??).  This is at 5:30AM, though, once more people are actively communicating, collisions and retransmissions are going to go up and increase those numbers.  Ok, now I have an IP address conflict - I have two Networks with a **192.168.1.0/24** subnet and while it may **somehow work**, it really shouldn't, because which network do you send packets destined for that subnet to?

### Doing an AC scan

I've got an `Intel Dual-Band AC 8260`

![Intel Dual-Band AC 8260](/images/ubiquiti/network_connection_1.jpg)

![Available networks - 3 extra are visible](/images/ubiquiti/network_connection_2.jpg)

OK, now we can see 3 additional networks using AC (80/160MHz widths) that are affecting things.  This is why doing a Spectrum Analysis is important - it shows any emissions from any source, not just WiFi and not just your compatible networks.

I'm going to switch this to a `192.168.11.0/24` network so we don't have any potential conflicts with subnets and then *jack in*.  I love my hard...lines.

![36ms of latency and ~300Mbps down](/images/ubiquiti/speed_test_cable_1.jpg)

### Speed Testing Woes

I do pretty in-depth testing of everything I do, because I know that without good, reliable and diverse information, it's easy to overlook things or get hoodwinked.  It went beyond the scope of this post and  [an exploration of our speed testing adventures is available in another post.](/2025-07-11-speed-tests.html).

## Radio 2 - 6.3.6

I wanted to explore a newer fw to see what it's like. First difference, they no longer recognize my homeland of "Compliance Testia" as a country.

![compliance test missing](/images/ubiquiti/uncountry.png)

And according to this, you can't downgrade to 5.6.6 without `TFTP`, which is no biggie, but whatevs.

![no downgrade for you](/images/ubiquiti/airos_uboot_fw.png)

### Let's Explore!

It still has `SSH` and `athstats`; Lupa says I can damage the power amp IC by using it without an antenna, and since it still broadcasts in station mode, I'm going to shelve it for now.

![athstats](/images/ubiquiti/636_athstats.png)

## References

[TekTronix Wi-Fi: Overview of the 802.11 Physical Layer and Transmitter Measurements](https://www.tek.com/en/documents/primer/wi-fi-overview-80211-physical-layer-and-transmitter-measurements)
	Tektronix, https://www.tek.com/en/documents/primer/wi-fi-overview-80211-physical-layer-and-transmitter-measurements#Transmit-Spect
	
[MCS Rates and Their Requisite SNR](https://d2cpnw0u24fjm4.cloudfront.net/wp-content/uploads/802.11n-and-802.11ac-MCS-SNR-and-RSSI.pdf)

[Ubiquiti's rather hard-to-find software page for the Rocket M5](https://ui.com/download/software/m5)

Upload proc-tree.txt to me and I can:

    Turn it into an interactive HTML tree

    Highlight any weird kernel modules, open FDs, etc.

    Pull out just the interesting /proc/sys, /proc/net, /proc/irq, etc.