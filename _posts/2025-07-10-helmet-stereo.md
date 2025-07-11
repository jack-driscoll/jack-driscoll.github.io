---
layout: post
title: "A Car Stereo For Your Head"
date: 2025-06-30
tags: [diy, electronics, hardware, biking, audio, audiophile, music]
permalink: /2025-07-10-helmet-stereo.html
description: "A Car Stereo For Your Head - DIY Audiophile-Quality 'System' for your motorcycle helmet; jackd builds an amplifier-powered motorcycle headset replacement with an audio technica ATH-M50 and two tested headphone amplifiers"
image: /images/mythic_support_small.png
---

# A Car Stereo For Your Head

**This page is under construction**

## The Beginning

I finally got a bluetooth module for my helmet - 2, actually.  I bought one and then one showed up on *Amazon Vine*, so I got a free one (that doesn't work properly).  The one that does sounds kind of janky.  I had an old pair of Audio-Technica ATH-M50 headphones where the connection between the earpieces broke and I decided, because I miss having 'a system' since my truck got towed, to put them in my motorcycle helmet.  Since every good system needs an amp, I got one of those, too.  I was going to get a neoteck (only 250mW, but looks decent) that was on sale, but the address was put in wrong.  So, thinking nothing of it, I cancelled the order to re-order with the right address, because I couldn't find a way to change it.  When I went to re-order, it was suddenly $19 instead of $12 (both on sale from $35).  This was the only cheap chinese one that stated the OP-AMP it uses and it's only on sale until the 6th.  They have free returns, though, so maybe I'll get it to compare.  In any case, I bought a different one that claims 350mW.  The AT phones can handle over 1W, though, so I may upgrade again in the future.

### ATH-M50

I'm using the drivers from an old pair of ATH-M50 where the cable connecting the two halves broke, so the drivers are still good.  The construction of the earpieces is very nice, the drivers are angled and there's baffling inside the phones.  We won't be able to do that (they don't fit in the helmet) but these things sound great and take a comparatively high.  They have a sensitivity of 99dB and take a maximum of 1,600 mW @ 1KHz!.  They have an impedance of 38 ohms, not high, but not low.  This will limit the amount of power we can push to them.

### Sacrificial Headset

I butchered a Mossy Oak bluetooth headset.  Mossy Oak, known for their high fidelity audio equipment, really shit their pants on this one.  It's the worst sounding one I've ever heard, but it's camoflage, which I need to reinforce my fragile male ego.  The driver is 31 ohms - great, close to my AT drivers.  The chip is a BL something, they almost never have datasheets, it's a chinese company.  I wish I would have gotten that magnifier the other day but I didn't have any Vine picks at the time.

### Patching in the 3.5mm jack

I'm just cutting up a cheapo 3.5mm cable.  My silver graphite audiophile woo-woo type shit cable isn't coming until tomorrow!  The wires are super tiny, the best way to do this is gently squeeze in the blades of the wire cutter, then angle it slightly and pull.  I only fucked up one of them!  I hooked these up to a bluetooth adapter.  At 1000kHz at 100%, the output is 15.3mV into 31 ohms.

### Testing

Hook up the alligator clips to the speaker, connect them to the DVM leads, then put another set of alligator clips connecting then DVM leads to the hacked wire.  I get 15.3mV at 100% volume - not great.  I can't use my webcam b/c the quality is shitty and I can't use my phone b/c I'm using it as a signal generator - wait, though, what if I generate the signal on my PC instead?  Brilliant.  And, Holy Shit, the output went up to over 300mV at full volume - what's up with that?

### Patching in the headphones

### Attaching the headphones

### Comparing Amplifiers

I was looking into using a generic class-D or class-T amplifier.  I've used the TA2024 and a 4x100 version whose chipset I can't recall; both sounded great.  I've been warned of what seems to me a slight increase in treble (my hearing cuts out around 14KHz usually anyway) and potentially "losing hearing due to high power 40-50 kHz" which I think is bunkum, because the drivers cut out around 28kHz anyways.

A 20W@4 ohm amplifier would put 2.5W into a 32 ohm load, theoretically, and probably at quite low THD.  However there's other issues (apparently) about driving "high impedance" drivers with class D.

[This 5V 5W amplifier](https://www.amazon.com/PAM8406-Amplifier-Potentiometers-Envistia-Mall/dp/B07R86BH6Q) for $5 (lot a fives) should put out 500mW into 32 ohms.  If I want more than that, looks like I'll need a boost converter, which I've done before with a 4x100W T-Amp in my truck (which sounded great, btw).

### Neoteck Headphone Amplifier

Someone online claimed these use "Texas Instrument OPA604 amp chips" and I could have sworn one of the online vendors listed the chip, but I'm not seeing it and I'm planning on opening it anyway.  According to the manual it should put a measly 100mW into the cans, which we're going to measure as well.

### No-name Headphone Amplifier

I opened this one and couldn't find the chipset, from "AB" online.  I decided to not waste my time looking and just test them, because I care more about results than names.

### Testing w/ an o-scope

🔬 Quick & Dirty Scope Test Ideas (if you want a reminder):

**Idle Noise Floor**
- Input shorted
- Scope across speaker terminals
- Look for baseline noise/hiss

**Sine Wave Test**
- Input known signal (1kHz @ ~200mV)
- Output on 8Ω dummy load
- Watch for clean waveform → distortion point

**Clipping Behavior**
- Slowly increase input
- Note where waveform flattens
- Bonus if symmetric and stable

**Thermal Drift**
- Let it run warm
- Watch for sag, oscillation, or power fade

### How do they sound

I'm going to measure the voltage before and after to verify amplification and output power.