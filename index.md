---
layout: home
permalink: /
date: 2025-06-04
title: Get'n Jack'D in CYBERSPACE!!!
nav_exclude: true
---

# Welcome to Jack'D

I'm Jack Driscoll — a multidisciplinary technician, systems thinker, creative worldbuilder and myth wrangler.  Please be patient, I'm in the process of re-imagining the world as we know it in a way that:

- respects autonomy
- acknowledges interdependence
- challenges dogma
- praises The Creator
- reduces harm
- offers mercy
- values efficiency
- protects nature
- venerates the cosmos
- promotes diversity
- shares love
- dreams big
- exists truthfully
- becomes better
- embraces death

I work across embedded systems, RF tools, manufacturing maintenance, FreeBSD/Linux networks, storytelling, and welded steel. I love troubleshooting, challenges, trying to do more with less, beautiful efficiency, fixing equipment and creating bleeding edge solutions.  As my home on the WWW, this site collects some of that work — built to load fast, work offline, and stay weird.  Think of this as `A 'Getting Started' Manual for Your Jack`.  I also have `The Care and Operation of Your Jack`, which Lupa described as "The Most Neurodivergent Thing I've Ever Heard".  

[Jump to Blog ↓](#blog-posts)

[Project Highlights](#highlights)

[Skills at a Glance](#skills)

[Markdown Gallery](#markdown-gallery)

---

## 🛠️ Highlights

- 🏗️ [Quick GitHub Pages Starter](https://github.com/jack-driscoll/quick-github-pages): A 9KB portable Jekyll base.
- 🌄 [The Plateaus](https://theplateaus.neocities.org): A surreal sports mythology built from the woods up.
- 🌐 [EtherTech.org](https://ethertech.org): Networked infrastructure for creative signal workers.
- 🖼️ [nanogallery2 Gallery Generator](https://github.com/jack-driscoll/auto-nanogallery2/): A python script that automagically generates thumbnails and gallery.json file!

---

## 🧠 Skills at a Glance {#skills}

- **Mechanical:** Hydraulics, pneumatics, welding, HVAC, blueprint reading.
- **Electrical:** AC/DC circuits, field wiring, looms/harnesses, structured wiring
- **Networking:** 802.11 troubleshooting, Linux routing, spectrum awareness, TCP/IP
- **Systems:** FreeBSD, Debian, bash/Python scripting, SDR toolchains.
- **Creative:** Worldbuilding, visual storytelling, minimalist web design.

For a more detailed view, check out [my intro](https://jackd.ethertech.org/intro/bio/2025/06/02/seriously.html) or [About Me](https://jackd.ethertech.org/about/).

---

© 2025 Jack Driscoll — Hand Coded with marinara sauce.

---

## Blog posts

<ul>
  {% for post in site.posts %}
    {% unless post.url == "/" %}
      <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        <small>{{ post.date | date: "%Y-%m-%d" }}</small>
      </li>
    {% endunless %}
  {% endfor %}
</ul>