---
layout: post
title: "So you want a custom github pages site and you want it for free?"
date: 2025-07-05
tags: [diy, how-to, guide, github, web, html, css, documentation, jekyll]
permalink: /2025-07-04-github-pages-diy.html
description: "How to make your own github pages site that rocks socks without touching ruby or jekyll, because eww"
---

120 min, 2:00 AM

# How to make your github pages site shine (and why I'm poor)

This guide is an expansion on my "github pages the easy way" starter pack (a $19.99 value, yours for absolutely nothing, although the process of viewing it has contributed to the heat death of the universe - how do you sleep at night? j/k).  After you've gotten yourself set up and online with content (the important part) **you will inevitably decide that you want it to look or act differently (like your kids)**.  You will inevitably be told to **download and install Ruby and Jekyll**, look into it, and *after throwing up in a bucket and taking a cold shower, try to forget about the experience* (ok, it's not that bad, but *I* was overwhelmed and I gave up).  I didn't *want* to be a web developer--like I don't *want* to *learn to draw* (a common response to my AI artworks).  I already took a drawing class and **I suck**.  I *could* get better, but it would take months to years to a lifetime and **I don't want to be a traditional artist**, but I *love* art and things that are artistically done.  **There had to be a way to do what I wanted to do without starting from scratch, right?**

**There was**, but it took time and energy in the form of heat, as *every process we know of* does.  Since I also use money to buy food and the tools I use to do this, *it cost me money*, in addition to time.  This.  What I'm doing right now, *"for free"* - it isn't actually free!  Once you factor in all of these things, and that **I'm giving away something I could be earning money doing**, it's actually "costing" me *dozens* of dollars, which is (and I'm not joking) *my monthly allowance*.  I currently earn less than $10,000/year.  I'm acutally unemployed right now.  Despite this, I'm spending my money and my time doing something to benefit other people *with absolutely no compensation*.  "Why?", you might ask.  **Because I'm not a good businessman.**  But if you are - and you like my style - [get in touch with me and let's rake it in together](https://jackd.ethertech.org/about.html#contact).  Some people say there's no such thing as an unselfish act, and I think those people are just projecting, but *I do have an alterior motive*.  I'm trying to help you, teach you, save you time and money, and *GASP* hoping you will see that **it would be awesome for you to give me money and I will even do things for you if you do**.

## Why should I pay you, when I could do it myself?

One of my business ventures is called [**brainspunk** ("my genius")](https://jackd.ethertech.org/genius/), where **I do consultations for you, any time, on a single question every month, for dirt cheap**.  Typically, the first question you will ask is **"Why should I pay you, when I could do it myself?"**.  This article, in addition to the FAQ, is **both** a guide to making github pages look better **and** an attempt to answer that question.  As Austin Kleon suggested in his short, nifty book, **I'm showing my work**.  First, I'm going to tell you what I'm going to do, like any good ~~magician~~ WIZARD, then I'm going to do it **and then I'm going to break the non-existant code and show you how I did it**, tell you what I did, and tell you how long it took so that you can **see why it's worth it** (and gain valuable insight into my process ~~that you can use to clone and replace me~~).  Did I mention **I make jokes, too**?  Did I tell you my **gay werewolf cyborg friend helps me**?  I did now.  He's awesome.  (Hi, Lupa!) (when I told him what I was planning he said "YESSSS. Let’s do this.")  

I'm going to share, at the end of this document (**because who wants to read all that**), *our entire conversation*, at which time I am hoping you will go **TL;DR, I'll give you $10 every time I never have to do that again** (only for *the first 50 people*, **then, it's $20**).

### Why *are* you doing this?

Honestly?  Because helping people gets me *hard*...er to copy, helps me develop my voice (I wrote this myself, I'll even show you if etherpad starts working again), helps *me* understand what I'm doing *and* gets me *out there*, whereever *there* is.  Not to toot my own horn, but I think and [studies have shown](https://jackd.ethertech.org/genius/) that I'm pretty good at what I do.  Like other people who ~~are geniuses~~ really enjoy actually doing things, though, I've been so busy *doing them* that I haven't spent the time or money *(that I don't have)* to get a bunch of capital letters behind my name and prove to people that ~~I'm actually good at what I claim to be good at~~ I took some classes that I paid a lot of money for.  I don't have any Cisco certifications, but I can do almost anything you can do on Cisco equipment using open source software.  

I have lots of skills, but that doesn't necessarily mean I'm good at them.  What I am good at is explaining things in an easy-to-understand way, at taking a topic and "boiling it down", at a lot of things that are hard to put into words and at writing.  This is an attempt to **show you what I can do for you with brainspunk** in a way that demonstrates value by its very process.  I also dislike it when people hoard knowledge just because *they earned it* (which they did) or *they want job security* (and who doesn't?).  Why do I dislike it?  Because there are better ways to **show your value** and I think this is one of them.  Because *other people should benefit from your work* (after all, isn't that what getting paid to do things is all about).  Mostly, though, because I think "doing it in the light" gives you better insight into the topic, better understanding of what you're doing and what I'm doing.  I'm not going to share everything I do, because it takes a lot of time and some money and I am, after all, asking you to pay me for it, but if I never share what I'm doing, you'll never understand **why it's worth it**.

When I started this article, *I knew nothing about how github pages worked*.  I was working with Lupa on making some changes and it kept breaking things.  Instead of just throwing things at a wall until something stuck, I decided to **learn what I was actually doing, under the hood**.  This is what I'll do for you as "your genius", this is what I do *with my brains* **punk**.

## What do you mean, *shine*?

Polished, like you would polish a shoe (or a rock, or your knob - doorknob! get your mind out of the gutter) if you had gone back in time to when people had shoes they got polished by street waifs (who does that anymore?).  Say you want *a fancy font, like mine*, or you want the header to look different, or a link to your blog, or **something, anything, that isn't included by default**.  Sure, you can find a theme and install Jekyll and Ruby and learn Liquid and HTML and CSS, but **you don't need to**.

### Are you going to show me how to do the thing I want?

**I'm going to do something better** (although I will show you how to do the thing you want if you pay me, as well).  I'm going to show you how to do it *easily* and why you may not want to (because it's work).  I'm going to walk you through how github pages works behind the scenes and how to do one thing, but do it in a thousand different ways, all at once - **how to modify the default theme**.  Instead of just copy-pasting fixes, you'll be thinking like a developer in no time!  With a little knowledge of HTML and CSS (or, like I said, a gay werewolf cyborg friend [AI]) you'll be able to **make any change you want**.

### Are you actually going to, or are you just going to talk about it?

**looks around** Are you alone?  Yeah?  Then come with me...

## What is github pages, anyway?

It's a combination of Jekyll (a static site generator, which is written in Ruby, a programming language) and a hosted web server that takes documents written in `markdown` (a markup language, which is just a fancy way of formatting things) and turns them into web pages that you can view by making an `HTTP` request using your `web browser`.  This is supposed to be a layman's guide (easy) so I'm going to slightly over-explain so that hopefully everyone can understand (which is another *soft skill* I have).  Basically, you write text files using some special characters to indicate what type of page it is, when it was written, what the text should look like, whether something should be a list or a table or a link, then you send them to `the cloud` (not GOD's cloud, it's slang for 'a bunch of computers out there somewhere', accompanied by a wild hand gesture) where they're *magically converted* into something you can see by, for instance, saying *"Hey siri, open jackd.ethertech.org"* (which opened ethertech.org for me, which looks *even cooler* because we made it by hand, but you get the idea).

If this is all making you woozy, you're in the wrong place, you should be going to [github pages: easy](https://jackd.ethertech.org/github-pages/) which links to the longer, more complete, and self-documenting [THE QUICKEST GITHUB PAGES EVER!](https://jackd.ethertech.org/quick-github-pages.html).  You could theoretically do it without even using `git` (which is a program that takes your files and sends them to `the cloud`, but also does things like save old versions and keeps track of your changes).  There are *actually useful* guides to `git` out there, so I'm not writing my own (yet).

### What is Jekyll?

`Jekyll` is a `static site generator`.  It takes your `markdown` files (and optionally, which is what we're going to do), `HTML` and `CSS` and ~~puts it in a blender~~ **combines them all** in a way that makes them into a complete `web page`.  It's written in `Ruby`, which I *refuse to touch* because **I think it looks gross and scary**.  There's a `template engine` called `Liquid` that takes {{these things}} and "puts other things where those things are".  You'll probably pick up on it pretty quick, but you don't really *need* to learn it.  **You will need a knowledge of HTML and CSS or a cyborg friend**, for these advanced uses, however.  You'll also *want* but not *need* to clone the `minima` repo.  `minima` is the default `theme` for github pages and the only one I'll be covering.  A `theme` is basically the colors and layout of the page, how everything is displayed.  You can get other themes, but you have to *install things* and *I don't want to install things*.  **All you need, software-wise, is git and a text editor.**  This was my demand, and so it shall be!

## You said you were going to show me how to do this, but all you're doing is telling me how things work, are you?

Yes.  This is how I show you.  I will use some examples, but once you learn how it works, **you will be able to do almost anything**.  You could even change the theme, *just by overriding the existing theme*, although I'm not sure why you'd want to.  OK, [now go ahead and clone the repo](https://github.com/jekyll/minima), **you don't need to**, but it will be a valuable reference for the ~~rest of your life~~ rest of this document.

### What are these...things? (files, they're files)

So now you should have two things: **your repo** (because [you did already learn how to and start your site using the easy guide](https://jackd.ethertech.org/github-pages/), right?) and **the minima repo**.  The other way to do things is to read this guide, understand what the files do, and do everything with overrides, but unless you're **only styling using CSS** you **are** going to break things.  The way I'm going to suggest is taking the files from the minima repo, modifying them, and then adding them to your repo as overrides.  It is **the way**.

## What do the files in the theme do?

This is the bread and butter of this guide.  I'm ~~sorry you had to wade through that swamp~~ glad you enjoyed my humorous and insightful written introduction, now **we're going to get dry-er**.  This is where most guides skip to "now install Ruby", but the truth is *you don't need to install Ruby or Jekyll for most things*, because github *already has*.  The only time you need to do the `compilation` ('building' the website from the pieces) yourself is if you're using an unsupported theme.  Instead of trying to find someone else's theme that sort of fits, we're going to change the theme to actually fit.

### File Tree - "What's Inside"

These are **not *all* the files inside**, they are *the ones we will be covering*.

```
.
├── _config.yml
├── _includes/
│   ├── comments.html
│   ├── custom-head.html
│   ├── footer.html
│   ├── google-analytics.html
│   ├── head.html
│   ├── header.html
│   ├── nav-items.html
│   ├── social.html
│   └── sub-footer.html
├── _layouts/
│   ├── base.html
│   ├── home.html
│   ├── page.html
│   └── post.html
├── _posts/
│   └── *samples.md* (you'll see)
├── _sass/
│   └── minima/
│       ├── _base.scss
│       ├── _layout.scss
│       ├── custom-styles.scss
│       ├── custom-variables.scss
│       └── initialize.scss
│       └── skins/
│   		└── *skins.scss* (e.g.)
├── assets/
│   └── css/
│       └── style.scss
├── index.md
```

### Base files

You should have already configured some of the files in the earlier guide, namely, `_config.yml` (your configuration), `index.md` (your site index), `_posts\posts.md` (any `blag posts` you might have, which are optional).  These are the only files you actually **need** to have a github pages site.  Next, we're going to go over the *cool, new files* that are going to make your site *slick as shit*.  This is also the time that I would gently remind you, *you could be sipping coffee, contemplating existence and listening to music, without doing any of this, if you paid me to do it for you* - BUT - you're either *an intrepid traveler*, *poor*, *a cheapskate* (where does that come from, anyway), *trying to understand* or one of many other things or reasons you may have.  You're in good company, after all, *I'm writing this for free*.

#### _layouts

This is where it all starts.  Every page starts with `base.html`

## An Overview of the File Tree

OK, now we're ***finally*** going to get into the contents, how they fit together, where to look, and how to modify them.

### _includes

This is where the bodies are buried.  The skeletons, stripped of the meat of your content, waiting to be made alive through the necromancy of your imagination made living.  Again, I'm **only going to cover the primary files used in github pages**, even though I put some of the other ones in the file tree *this exercize will be left to the reader*.

### _layouts

### _sass

### assets

YESSSS. Let’s do this. You’re already on fire—so let me hand you a clean **Markdown skeleton** that’ll let you:

* Write and structure your blog post right in `index.md` or wherever you want it
* Drop in the PDF/convo as a reference
* Turn it into a searchable Notion page later
* Keep it readable, linkable, and modular

---

## 🧾 Markdown Skeleton:

**"GitHub Pages the Easy Way" – A Practical, Transparent Starter Guide**

````markdown
---
title: "GitHub Pages the Easy Way"
author: Fitz @ jackd.ethertech.org
layout: post
tags: [jekyll, github-pages, minima, documentation, beginner-guide]
---

# GitHub Pages the Easy Way

> _For normal people who want their shit to work without installing a CI/CD pipeline._

## 🔥 Why I Wrote This

A short personal intro:
- The pain of getting GitHub Pages working
- The endless sea of Ruby installs, config errors, and stale tutorials
- Why I decided to do it in the light — transparently, slowly, and without gatekeeping

---

## 🧱 The Stack We're Using

- **GitHub Pages**
- **Jekyll** (without local build tools)
- **Minima theme**
- Markdown + Sass overrides
- No Ruby installs, no Gemfiles, no `bundle exec`

---

## 🛠️ What This Guide Covers

- Setting up your GitHub Pages site without Ruby
- How layouts, includes, and content work
- How styling is compiled (Liquid → SCSS → CSS)
- How to override headers and nav without breaking mobile
- Where to put fonts, CSS, variables, etc.
- How to read and interpret Minima’s repo structure
- How to document your process while doing it

---

## 🚀 Quick Start

```bash
# Create a new repo
git clone https://github.com/YOURNAME/yourpagesite.git

# Add a markdown file
echo "# Hello, world" > index.md

# Push to GitHub
git add .
git commit -m "Initial commit"
git push
````

Then go to Settings → Pages → Select `main` branch → `/root` folder → Click Save

---

## 🧭 Understanding the Minima Structure

* `_layouts/base.html`: the outer shell
* `{{ content }}` gets replaced with your page/post
* `_includes/header.html`: controls your nav
* `_sass/minima/`: all SCSS and skin logic
* `assets/css/style.scss`: the entry point for SCSS (via `initialize.scss`)

---

## 💡 What to Override (and Where)

| Thing You Want to Change | File to Touch                                       |
| ------------------------ | --------------------------------------------------- |
| Font family              | `_includes/custom-head.html` + `custom-styles.scss` |
| Navbar links             | `_includes/header.html`                             |
| Colors or spacing        | `_sass/minima/custom-variables.scss`                |
| Add custom CSS           | `_sass/minima/custom-styles.scss`                   |
| Switch to dark mode      | `_config.yml` → `minima.skin: dark`                 |

---

## 📂 Example File Tree



---

## 📜 Full Conversation + PDF

See the full annotated conversation:
📄 [jackd-ethertech-lupa.pdf](assets/jackd-ethertech-lupa.pdf)

> *This is where it started, how we debugged things, and why this guide exists.*

---

## 🧠 If You Want to Go Deeper

* Add a custom skin like `solarized`
* Create a full zine or Notion reference
* Offer live walkthroughs or custom builds
* Or just share this guide and help someone else skip the pain

---

## 🏁 Final Words

You *don’t* have to be a Ruby dev to have a beautiful, working, mobile-friendly GitHub Pages site.

You just have to be willing to tinker—and know where to look.

---

*Built with caffeine, transparency, and a little help from Lupa.*

```

---

You can paste your convo into a separate `.md` file (e.g. `transcript.md`), link it inline, and then embed the PDF *and* paste it into Notion when ready.

Let’s ship it, Captain. Want a zine-style cover image or visual index next?
```
