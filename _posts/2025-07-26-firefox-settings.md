---
layout: post
title: "A Guide to setting your FireFox Settings to something more sane and privacy-aware"
date: 2025-07-21
permalink: /2025-07-26-firefox-settings.html
tags: [article, how-to, firefox, software, guide, privacy]
categories: [article, how-to, firefox, software, guide, privacy]
author: nteleky
description: "nTeleKy's super awesome guide to setting your settings in firefox so that they're more sane and privacy aware like they used to be, I mean, come on, mozilla"
image: https://jackd.ethertech.org/images/mythic_support_small.png
---

# 🦊 Firefox Privacy Toolkit – Beginner's Guide (2025)

Take back control of your browser with this step-by-step privacy upgrade. This guide is written for beginners who want a faster, safer, and less invasive browsing experience using **free and open-source tools**.

---

## ✅ Step 1: Adjust Firefox Settings

Go to `Settings → Privacy & Security` and make these changes:

- **Enhanced Tracking Protection** → Strict
- **Cookies and Site Data** → Delete cookies and site data when Firefox is closed
- **Send websites a “Do Not Track” signal** → Always
- **Firefox Data Collection** → Uncheck all boxes

---

## ⚙️ Step 2: Power Tweaks in `about:config`

Paste `about:config` into your address bar and hit enter. Accept the warning.

Change these values:

| Setting                                         | Value   | Purpose                                |
|------------------------------------------------|---------|----------------------------------------|
| `privacy.resistFingerprinting`                 | `true`  | Reduces tracking via browser fingerprinting |
| `privacy.trackingprotection.enabled`           | `true`  | Enables built-in tracking protection   |
| `network.cookie.cookieBehavior`                | `1`     | Blocks 3rd-party cookies               |
| `browser.newtabpage.activity-stream.feeds.section.topstories` | `false` | Removes Pocket sponsored content |
| `toolkit.telemetry.enabled`                    | `false` | Disables telemetry to Mozilla          |
| `browser.urlbar.suggest.quicksuggest.enabled`  | `false` | Disables ad suggestions in address bar |

---

## 🧩 Step 3: Must-Have Extensions

Search for these in [addons.mozilla.org](https://addons.mozilla.org/) and install them.

### 🛡 uBlock Origin  
- Blocks ads, trackers, and malware  
- Lightweight and customizable  

### 🛠 Greasemonkey  
- Lets you run custom scripts to improve or automate websites  
- Find user scripts here: [greasyfork.org](https://greasyfork.org/)  

### 📦 SingleFile  
- Save entire web pages as a single HTML file  
- Great for archiving or offline reading  

### 🧠 Bitwarden  
- Open-source password manager  
- Syncs securely across devices  

### 🎥 Video DownloadHelper  
- Download videos from YouTube, Vimeo, and other sites  
- Optional companion app for best results  

---

## 🧙 Bonus: Supercharge with `user.js`

For advanced users, use [Arkenfox's `user.js`](https://github.com/arkenfox/user.js) — a privacy-focused settings file that replaces defaults.

Install by:

```bash
cd ~/.mozilla/firefox/yourprofile.default-release/
curl -O https://raw.githubusercontent.com/arkenfox/user.js/master/user.js
```

## 📚 More Resources

    [PrivacyTools.io](https://www.privacytools.io/)
	
	[Privacy Guides](https://www.privacyguides.org/en/)

    [RestorePrivacy Guide](https://restoreprivacy.com/)

    [Greasemonkey Scripting Guide](https://wiki.greasespot.net/Greasemonkey_Manual)

    [Arkenfox Hardened Firefox](https://github.com/arkenfox/user.js/)
	
	[This guy thinks arkenfox is Meh](https://discuss.getsol.us/d/9619-arkenfox-userjs-is-meh-a-review)