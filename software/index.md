---
layout: page
title: "Software"
date: 2025-07-09
tags: [guide, documentation, software, links]
permalink: /software/
author: nteleky
description: "A Guide to The Best Software, linux and windows, mostly open-source, an awesome guide to exemplary programming, by nTeleKy and Lupa"
---

# The Best Software

I was gonna add something to my `/links.html` but decided (in my typical ADHD fashion) to create an entire reference guide to essential, amazing, or otherwise exemplary programming, as a reference for myself and others.  I used to love finding little treasure troves of links when I was a little aspiring h4x0r.  I used to love finding a kindred spirit on StumbleUpon and digging through what they found neat, fascinating and driving.  I used to love finding a cool fserve or FTP or repository.  It's a way to find cool things you aren't even looking for that's lacking in search engines and a way to prevent me from forgetting about awesome utilities (although let's be honest - if it affects your life enough, you remember).  As opposed to my (labeled and categorized) 'junk drawer' of links, this is curated and pruned.

This is a work in progress.  Ironically enough, I already forgot what I was going to add to the top of my **links**...*"I'm sure it'll come back to me**...

## FreeBSD

At the top, as it should be.  My absolute, hands-down favorite OS.  I'm not sure how I got started on FreeBSD, whether it was because it was *even more obscure* than linux, or it had a claim to *the oldest* lineage of the open source OS's.  In any case, though, I've experimented and used daily DOS (6.22, mainly), Windows, linux, FreeBSD and macOS (the easiest, most streamlined experience).  I've played with OpenBSD, netBSD and dozens of linux distributions, from <8MiB embedded systems to the **12GiB** Kali Everything (it says something that I think this is *huge*).

I'm not saying **FreeBSD is better**, I'm saying *"it's what I want in an Operating System"*.  The difference isn't something I can point at, it's in how it feels to use.  Even when I encounter a problem, it's not *frustrating* in the same way, because it's designed to be visible and fixable.  It's always a PEBKAC issue, or dysfunctional user-land utilities - well *almost* always.  And if I want to *go deep* and fix it myself, *I can*.  

It's an OS designed by and for *sysadmins* - the people that run the systems and have to fix them.  Linux is designed by *programmers*, Windows is designed by *businessmen* and Mac OSX is designed by *designers*.  No one of the is "better", they're just different systems for different people, and if I want to be anything, I want to be a *sysop*.

There's no *killer app*, no *market* and no *beautiful interface*, but I find the beauty in its functionality.  It works, reliably, it's easy to *work on* and it's *an enjoyable experience*.  Every other OS, in comparison, I feel like they sacrificed usability and ease-of-maintenance for *something*, whereas FreeBSD they sacrificed other things for *clarity*, *stability* and *control*.  I've had boxes that ran for years and only went down due to no UPS and a power outage.  You can *compile from source* and *upgrade every userland application* **without rebooting**.  As soon as you restart the process, it launches the new version.  The only thing you *really* need to reboot for is upgrading the kernel.  

The kernel and all the *system-level* software is bundled together, designed together, and tested together, as a unit.  The filesystem layout is predictable, dependable, and unchanged *for decades*.  If I'm trying to find something, I know where to look based on *what it is*, not on *who wrote it* or *what version it is*.  If you want to run your software on FreeBSD you adapt the *software* to the *OS*, not the other way around.  The documentation is readable, complete, and installed by default `man which`.  If you're running the base system, you literally never have to consult the internet or a manual because *it's already there*, installed, readable, and *stored as text*.  **Did I mention Ctrl+PgUp/PgDn still works?**

Configuration, logs, even system input and output is almost always *text*, when possible.  Want to read the logs or parse them?  You use the *same applications you learned 20 years ago*, like `cat`, `grep`, `tail`, and `find`.  Changes need to be *justified* before they're implemented.  Compatibility is paramount.  **Everything is a file** is the UNIX philosophy, and unlike other OS's you don't need a special app to read the fucking log files, all you need is your eyes and access to the data.  Most importantly, *Lennart Poettering has nothing to do with it*.  I still believe he's a a chaos agent sent to fracture the Linux world before defecting to Microsoft. Convince me otherwise.

<h2>Markdown Files (With Titles)</h2>
<ul>
  {% assign software_pages = site.pages | where_exp: "p", "p.path contains '/software/'" %}
  {% for page in software_pages %}
    <li><a href="{{ page.url | relative_url }}">{{ page.title | default: page.name }}</a></li>
  {% endfor %}
</ul>

<h2>Other Files</h2>
<ul>
  {% for file in site.static_files %}
    {% if file.path contains '/software/' and file.extname != '.md' %}
      <li><a href="{{ file.path | relative_url }}">{{ file.name }}</a></li>
    {% endif %}
  {% endfor %}
</ul>

{%- for path in page_paths -%}
  {%- assign my_page = site.pages | where: "path", path | first -%}
  {%- if my_page.title and my_page.url != '/' -%}
  <a class="page-link" href="{{ my_page.url | relative_url }}">{{ my_page.title | escape }}</a>
  {%- endif -%}
{%- endfor -%}

<div style="text-align: center; margin-top: 2rem;">
  <a href="/images/portal_600dpi.png" title="click to unlock a deeper world">
    <img src="/software/portal.png" alt="Portal Sigil" style="max-width: 1500px;" />
  </a>
</div>