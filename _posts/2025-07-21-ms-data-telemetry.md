---
layout: post
title: "EWWWW, Microsoft, stay away from my data -nTeleKy"
date: 2025-07-21
tags: [diy, how-to, guide, microsoft, windows, windows 10]
permalink: /2025-07-21-ms-data-telemetry.html
author: nteleky
description: "How to disable data collection, telemetry, and block micro$oft from mining your local data, which they conveniently opted you into without asking, eww"
image: https://jackd.ethertech.org/images/mythic_support_small.png
---

# Eww, gross, stay away from my local data, Bill

I don't want you all up in my system.  No.  Stay away, plz.  Thank you.  This all started because they changed my search bar and half of my programs aren't in it, anymore.  Then, I realized they were indexing my whole drive and *jokingly* asked if they were sending it all to **Micro soft penis** HQ *and they were*.

## How?

Bill is probably not going to listen and do whatever he wants, look at this:

![watching Bill invade my privacy with no recourse](/images/ms_search.png)

This image **screams**:

### 🚨 1. **Search is indexing your entire damn hard drive**

You didn’t opt into that — it’s likely a side effect of:

* **Windows Search’s "Enhanced" mode**, enabled silently in some builds
* Search integration with **cloud sync / OneDrive / Copilot**
* **Microsoft Defender**’s “content awareness” pulling double duty

You typed “shit” and it found:

* Documents
* Folders
* PNGs
* ...all **deeply nested**, some probably from `~/Desktop/screenshots` or backups

---

### 🕵️ 2. **Are They Sending It to Microsoft?**

Short version: **Yes — if you're using Bing/Copilot/Web Search**.

Here's what gets shared when those services are live:

* Search terms
* Some file paths
* App usage history
* Your **search interactions** (which suggestions you click)

Even **local file names** can be analyzed if:

* **"Search Highlights"** is enabled
* **"Cloud content search"** is on
* You’re logged into a Microsoft account


### What is currently handling search?

🧠 What Could Be Handling Search on Your System
|Component|	Role	|Where to find                              |
| ------- | ------------------------------------------- |---------|
|**SearchHost.exe** |	Classic indexed local search host	| Older or controlled builds only|
|**SearchApp.exe**	| Modern Start search / cloud integration	| C:\Windows\SystemApps\Microsoft.Windows.Search_*|
|**StartMenuExperienceHost.exe**	| Start menu UI shell	| UI layer only, doesn’t search|
|**TextInputHost.exe / WindowsShellExperienceHost.exe** |	Backend UI glue / animations	| Peripheral control|
|**CopilotSearchService.exe** | (newer builds)	Web-integrated AI junk	| Canary/dev builds only so far|


## 🛡️ Turn Off the Shit Funnel

### 🔧 Turn Off Enhanced Indexing

1. `Settings` → `Search` → `Searching Windows`
2. Set to **Classic** mode
3. Remove everything from **“Excluded Folders”** list and then re-add folders you **don’t** want indexed

---

### 🛑 Kill Web + Cloud Search Integration

#### Registry or PowerShell:

```powershell
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "AllowSearchToUseLocation" -Value 0 -PropertyType DWord -Force
```

---

### 💬 Optional: De-cloud Cortana and Copilot

Turn off **"cloud content search"** in:

```
Settings > Privacy & security > Search permissions
```

Set **“Microsoft account content”** and **“Work or school account content”** to **Off**.


### Find and disable search

Get-ChildItem "C:\Windows\SystemApps\" | Where-Object { $_.Name -like "*Search*" }

Stop-Process -Name "SearchApp" -Force
Start-Process "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe"

### Disable web search

> # Disable Web Search in Start
> New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -PropertyType DWord -Force
> New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "AllowSearchToUseLocation" -Value 0 -PropertyType DWord -Force

## Group Policy Disable

Disable this shit in Group Policy Editor (gpedit.exe)

![disable this shit](/images/ms_disable.png)

![disable this shit, too](/images/ms_disable_2.png)

## Disable This Shit in Settings

Disable this shit in Settings 

![disable this shit](/images/ms_settings.png)

![disable this shit, too](/images/ms_settings_2.png)

1. **Turn off "Let Windows track app launches"**
   This one is subtle but real.

2. **Turn off "Suggested content in Settings"**
   This uses browsing and system behavior to customize UI.

3. **Disable `DiagTrack` + `dmwappushsvc` services**

   ```powershell
   Stop-Service DiagTrack -Force
   Set-Service DiagTrack -StartupType Disabled

   Stop-Service dmwappushsvc -Force
   Set-Service dmwappushsvc -StartupType Disabled
   ```
## 🛠 What's Still Worth Flipping?

Here’s what I’d recommend if you want to **go maximum feral**:

### 🧨 Set These to "Disabled":

* `Configure Connected User Experiences and Telemetry`

  > Already **Enabled** — flip to **Disabled**.
* `Allow Telemetry`

  > Explicitly set to **Disabled** even if inherited.
* `Limit Enhanced diagnostic data to the minimum required...`

  > Set to **Enabled**, with minimum selected (if not disabling entirely).

### 🔐 Optional Tweaks

* `Disable deleting diagnostic data`: Enable (stops MS from wiping audit trail)
* `Disable diagnostic data viewer`: Enable (blocks sneaky visibility gaps)

---

## 🧪 Wanna Go Nuclear?

You can also:

* 🔥 Block these telemetry domains at your **hosts file**, firewall, or router:

  ```
  settings-win.data.microsoft.com
  vortex.data.microsoft.com
  watson.telemetry.microsoft.com
  telemetry.microsoft.com
  ```
  
### 🛡 Step-by-Step: Block Telemetry Domains/IPs with Windows Defender Firewall

#### 🔹 1. Open PowerShell as Admin

Paste this to block known telemetry endpoints:

```powershell
$telemetryDomains = @(
  "vortex.data.microsoft.com",
  "settings-win.data.microsoft.com",
  "telemetry.microsoft.com",
  "watson.telemetry.microsoft.com",
  "oca.telemetry.microsoft.com",
  "sqm.microsoft.com",
  "wdcp.microsoft.com",
  "tsfe.trafficshaping.dsp.mp.microsoft.com"
)

foreach ($domain in $telemetryDomains) {
  New-NetFirewallRule -DisplayName "Block $domain" `
    -Direction Outbound `
    -RemoteAddress $domain `
    -Action Block `
    -Enabled True `
    -Profile Any
}
```

☢️ **Caveat:** Some domains (like `*.microsoft.com`) use rotating IPs or CDNs — for deeper blocking, use FQDN-aware firewalls or tools like [SimpleWall](https://www.henrypp.org/product/simplewall) (Windows) or pfSense rules if you’re routing through a LAN box.

## 3rd-party search bar

Third-Party Start Menu (ExplorerPatcher, StartAllBack)

Fully restores:

    Classic Start Menu

    Proper indexing

    No ads/games/search slop

ExplorerPatcher is free.
StartAllBack is $5 and incredibly polished.

### Everything Search

Use Everything Search

Everything is:

    Instant

    Local only

    Immune to Start Menu shenanigans

Assign it to Win+Space or Ctrl+Alt+F.

## 🔧 Remaining Optional Polishes

If you want to push the edge even further:

[x] Mention OneSettings, NCSI, and Microsoft Compatibility Appraiser if you're feeling extra rude

[ ] Schedule firewall rules refresh via task scheduler (for those slippery CDNs)

[ ] Build a “feral install script” repo or .zip bundle for rapid deployment on new machines

### the fuck is NCSI?

#### 🧠 TL;DR

| Feature | What It Does                                |
| ------- | ------------------------------------------- |
| NCSI    | Probes Microsoft to confirm internet status |
| Risk    | Silent outbound ping, leaks presence        |
| Disable | Registry: `EnableActiveProbing = 0`         |


[disable in the registry](/assets/disable_ncsi.reg) Run as Admin (gives me full control of your computers, so I can hack the gibson)

---

**NCSI** = **Network Connectivity Status Indicator**

It’s a little background component in Windows that *looks innocent*… but it pings Microsoft every time your system connects to a network to decide **"Am I online?"**

---

#### 🧪 What It Actually Does

Every time you connect to Wi-Fi or Ethernet, **NCSI** does this:

1. Makes an HTTP request to:

   ```
   http://www.msftconnecttest.com/connecttest.txt
   ```

   (Expected result: plain text response `Microsoft Connect Test`)

2. Sometimes also probes:

   ```
   dns.msftncsi.com
   ```

3. If it gets the expected response:

   * Green checkmark appears in your system tray
   * Windows reports "Internet access"
   * Some services (like Edge, Microsoft Store, or Defender updates) activate

---

#### 🚨 Why You Might Not Like That

* It **automatically contacts Microsoft** *even if you didn’t open a browser*
* It **bypasses proxy settings** to avoid being intercepted
* It can **leak network presence** when you're on a restricted, captive, or airgapped LAN
* It's **hardcoded** into Windows networking stack — even **airplane mode recovery** depends on it

---




