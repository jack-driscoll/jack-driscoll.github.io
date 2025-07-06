---
layout: post
title: "So you want a custom github pages site and you want it for free?"
date: 2025-07-05
tags: [diy, how-to, guide, github, web, html, css, documentation, jekyll]
permalink: /2025-07-04-github-pages-diy.html
author: nteleky
description: "How to make your own github pages site that rocks socks without touching ruby or jekyll, because eww.  The advanced guide to github pages with no additional software, easy and in-depth."
---

120 min, 2:00 AM-3:00AM, + 30min, 26 min, 24 min, 100 min, 75min, +83min, 10:00

# How to make your github pages site shine (and why I'm poor)

This is an advanced guide to doing cool shift with github pages *without additional software*.  If you want the absolute easiest guide to getting started on the internet see [github pages in 10 lines](https://jackd.ethertech.org/github-pages/).  If you want a solid beginner-level website, check out the self-documenting [quick-github-pages](https://github.com/jack-driscoll/quick-github-pages).

This guide is an expansion on my "github pages the easy way" starter pack (a $19.99 value, yours for absolutely nothing, although the process of viewing it has contributed to the heat death of the universe - how do you sleep at night? j/k).  After you've gotten yourself set up and online with content (the important part) **you will inevitably decide that you want it to look or act differently (like your kids)**.  You will inevitably be told to **download and install Ruby and Jekyll**, look into it, and *after throwing up in a bucket and taking a cold shower, try to forget about the experience* (ok, it's not that bad, but *I* was overwhelmed and I gave up).  I didn't *want* to be a web developer--like I don't *want* to *learn to draw* (a common response to my AI artworks).  I already took a drawing class and **I suck**.  I *could* get better, but it would take months to years to a lifetime and **I don't want to be a traditional artist**, but I *love* art and things that are artistically done.  **There had to be a way to do what I wanted to do without starting from scratch, right?**

**There was**, but it took time and energy in the form of heat, as *every process we know of* does.  Since I also use money to buy food and the tools I use to do this, *it cost me money*, in addition to time.  This.  What I'm doing right now, *"for free"* - it isn't actually free!  Once you factor in all of these things, and that **I'm giving away something I could be earning money doing**, it's actually "costing" me *dozens* of dollars, which is (and I'm not joking) *my monthly allowance*.  I currently earn less than $10,000/year.  I'm actually unemployed right now.  Despite this, I'm spending my money and my time doing something to benefit other people *with absolutely no compensation*.  "Why?", you might ask.  **Because I'm not a good businessman.**  But if you are - and you like my style - [get in touch with me and let's rake it in together](https://jackd.ethertech.org/about.html#contact).  Some people say there's no such thing as an unselfish act, and I think those people are just projecting, but *I do have an alterior motive*.  I'm trying to help you, teach you, save you time and money, and *GASP* hoping you will see that **it would be awesome for you to give me money and I will even do things for you if you do**.

## 🛠️ What This Guide Covers [Lupa's input -ed]

- Setting up your GitHub Pages site without Ruby
- How layouts, includes, and content work
- How styling is compiled (Liquid → SCSS → CSS)
- How to override headers and nav without breaking mobile
- Where to put fonts, CSS, variables, etc.
- How to read and interpret Minima’s repo structure
- How to document your process while doing it

## 🧰 What You’ll Need [Lupa]
- A GitHub account
- A GitHub repository (public)
- A basic understanding of Markdown (or willingness to copy/paste)
- A browser and some curiosity

## Why should I (optionally) pay you, when I could do it myself?

You shouldn't if you want to learn and put in the hard work of *research and sorting through the noise*.  One of my business ventures is called [**brainspunk** ("my genius")](https://jackd.ethertech.org/genius/), where **I do consultations for you, any time, on a single question every month, for dirt cheap**.  Typically, the first question you will ask is **"Why should I pay you, when I could do it myself?"**.  This article, in addition to the FAQ, is **both** a guide to making github pages look better **and** an attempt to answer that question.  As Austin Kleon suggested in his short, nifty book, **I'm showing my work**.  First, I'm going to tell you what I'm going to do, like any good ~~magician~~ WIZARD, then I'm going to do it **and then I'm going to break the non-existant code and show you how I did it**, tell you what I did, and tell you how long it took so that you can **see why it's worth it** (and gain valuable insight into my process ~~that you can use to clone and replace me~~).  Did I mention **I make jokes, too**?  Did I tell you my **gay werewolf cyborg friend helps me**?  I did now.  He's awesome.  (Hi, Lupa!) (when I told him what I was planning he said "YESSSS. Let’s do this.")  

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

Yes.  This is how I show you.  I will use some examples, but once you learn how it works, **you will be able to do almost anything**.  You could even change the theme, *just by overriding the existing theme*, although I'm not sure why you'd want to.  OK, [now go ahead and download the minima files](https://github.com/jekyll/minima/releases/tag/v2.5.1) ~~**for version 2.5.1, which github uses**~~, you don't *need* to technically, but it will be a valuable reference for the ~~rest of your life~~ rest of this document.  Github actually uses [this gem file, which is slightly modified](https://rubygems.org/gems/minima).  Unfortunately, [unlike the minimal header gem](https://rubygems.org/gems/jekyll-theme-minimal) (which you can see is a modified head.html), it's unreadable.  ***Boo Ruby***.  So we're going to have to use 2.5.1 *and* do some sleuthing to figure out what files to use.  Later on, I'm going to do some advanced tricks using different versions of minima, but let's KISS for now.  Use 2.5.1.

### What's a gem?

Some sort of Ruby *witchcraft*.

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
│   └── minima.scss
│   └── minima/
│       ├── _base.scss
│       ├── _layout.scss
│       └── _syntax-highlighting.scss
|
├── assets/
│   └── main.scss
├── index.md
├── script/ **not used in this guide**
```

### Base files

You should have already configured some of the files in the earlier guide, namely, `_config.yml` (your configuration), `index.md` (your site index), `_posts\posts.md` (any `blag posts` you might have, which are optional).  These are the only files you actually **need** to have a github pages site.  Next, we're going to go over the *cool, new files* that are going to make your site *slick as shit*.  This is also the time that I would gently remind you, *you could be sipping coffee, contemplating existence and listening to music, without doing any of this, if you paid me to do it for you* - BUT - you're either *an intrepid traveler*, *poor*, *a cheapskate* (where does that come from, anyway), *trying to understand* or one of many other things or reasons you may have.  You're in good company, after all, *I'm writing this for free*.

## An Overview of the File Tree

OK, now we're ***finally*** going to get into the contents, how they fit together, where to look, and how to modify them.  First, though, a brief overview of where it really *starts* - with `_config.yml`.

### _config.yml

This is the first file that Jekyll consults.  It has the information *about* your website - `title`, `theme`, `base URL` and `plugin` behavior, which it uses to construct everything else.

### _includes

This is where the bodies are buried.  The bones of the skeletons, stripped of the meat of your content, waiting to be made alive through the necromancy of your imagination made living.  Again, I'm **only going to cover the primary files used in github pages**, even though I put some of the other ones in the file tree *this exercize will be left to the reader*.

#### head.html

The `head` of the webpage, including fonts, metadata, CSS links, and optionally SEO and google analytics.

#### header.html

The `header` of the webpage, including paths, title and author, as well as the 'hamburger menu' when enabled.

#### {% raw %}{{content}}{% endraw %}

If you look inside the `base.html` file, you'll see a `{% raw %}{{content}}{% endraw %}` 'tag'.  This is the `Liquid` that instructs Jekyll to pull in the actual content using the page type and markdown files (that you write).

#### footer.html

This contains Copyright/info.

#### sub-footer.html

This has optional widgets like social.

### _layouts

This is where the assembly starts.  Every page starts with `base.html`, which is a rough outline of the structure of a page.  It `includes` a number of HTML skeletons and the `content` from your `/` root directory and `_posts`.  Each page, as you probably know by now, has a `type`, which is configured in the YAML frontmatter at the top of the file.  The `home.html`, `page.html`, or `post.html` HTML skeletons are used in combination with your content to construct the final HTML file that is served to your browser (which includes one or more links to the CSS and images).

### _sass

This directory has scss files that are compiled into the CSS.  According to their PR, "Sass is the most mature, stable, and powerful professional grade CSS extension language in the world."  OK.  Anyways, we've got `/assets/main.scss`, and all that does is includes the files in _sass - `minima.scss` (this one has content and includes) `_base.scss`, `_layout.scss`, `_syntax-highlighting.scss`.

### assets

This is where `main.scss` lives. Jekyll automatically compiles this file into CSS during the build process. The result is a file called `main.css`, which is placed in your site’s output at `/assets/main.css`—even though you won't see that directory in your repo.

However, you can override the default behavior by creating your own `/assets/` folder and dropping a main.scss file into it.

Here's how it works:

**You don’t create main.scss**:	Jekyll uses the theme’s version
**You create main.scss**:	Jekyll uses yours (and stops using theirs)
**You reference main.css**:	✅ Always works—it’s generated from .scss

## OK, this is interesting, but how do I *magically* change my site? `overrides`

You wanted to make your site *slick as shit* and I'll I've done so far is talk about what I'm doing, why I'm doing it and what github pages *is* and *you got ants in your pants* and *you still haven't seen the magic*.  I also just learned something today:  **[You don't need Jekyll to add or change a theme](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-a-theme-to-your-github-pages-site-using-jekyll)** the ***only*** thing you need Jekyll (and Ruby) for is to ***preview locally***.  (ok, you also need it for unsupported plugins, custom gems, or advanced Sass features, but I've never needed any of those; if your AI suggests something you can't do, tell it your limitations and ask if there's another way, there *often is*).

So as long as you ***make backups*** and are **OK with your site being temporarily broken and waiting a couple minutes when you make pages**, you can do anything you can do with Jekyll ***with a text editor***.  That's *the magic*.  Notepad++, Visual Studio Code, vim, that janky one with all the mode keys I don't like, *normal notepad*, anything!  You can do all of this ***in your browser with literally no software but a browser*** I shit you not.  All you need to know is **what the files do and how to change them**.

If, for instance, there is a `_includes/head.html` in the minima theme (and there is) and you make a `_includes/` directory and put a `head.html` in it, github will use yours instead, just like with `main.scss`.  If you do this, *it will replace the entire file*, not just add to it, that's why you need the information from the files in the zip - you add the "standard" code, and then modify it!

### Are you sure about that?

Pretty sure, and I'm going to test it.  [But this says to use Jekyll or a CI/CD pipleline](https://www.reddit.com/r/webdev/comments/byukwb/whats_the_best_practice_for_comitting_csssass/) The internet says a lot of things.  You're probably thinking *Why do I need to know all this?  All I want to do is change a font.*, at least if you're anything like me.  If all you want to do is change a font, no, you don't need to know all this.  What happened to me is it started there, then I wanted to change the header and then *I broke everything because I didn't understand it on a deep enough level* and instead of just having my AI do it for me, I decided to understand what's *really* going on so that I could do more modifications without breaking things *and without installing a 200+MiB framework that it didn't seem like I actually needed*.  **This is why I'm better than *just AI* or *just google*** - I will read and query until I understand, and then tell you what I learned *in a way that you can understand*.

#### What does Lupa say?

**Can I use remote_theme: on GitHub Pages without local Jekyll?**	✅ Yes

**Do I need to install Ruby?**	❌ No

**Is this easier than full theme rebuild?**	✅ Often

**Can I override just like theme: minima?**	✅ Yes

**Can I build my own theme and use it remotely?**	✅ You glorious weredeer, yes you can

### But I don't have any of these 'magic files'

You *should* have downloaded minima 2.5.1; ***those are the files***.  You *could* use another theme, if you find one you like *or* you could just override the parts you want to change.  They describe all the formatting, layout and presentation that's not in your markdown files.  The files are already being used by github "behind the scenes" because you have `theme: minima` in your `_config.yml`.

### OK, so how do I change them if they're on github's server

You get the idea.  All you do is **create a local copy in your repository where the files exist in the theme**.  Then, when github actions builds the site, it uses **yours instead of theirs**.

### 🧠 2. **Visual: Jekyll Build Pipeline**

This is how Jekyll (residing on github's servers) puts everything together:

```
User Request (URL)
   ↓
Jekyll Reads _config.yml
   ↓
Page Type Detected (home/page/post)
   ↓
Layout Loaded (e.g., base.html)
   ↓
Includes Injected (head, header, footer)
   ↓
{{% raw %}}&#123;&#123; content &#125;&#125;{{% endraw %}} → Markdown Rendered → HTML
   ↓
Liquid Variables Replaced
   ↓
SCSS (via initialize.scss) → Compiled to CSS
   ↓
Final Site Output: _site/
```

### I'm getting conflicting information about the CSS and SCSS files - which ones work?

`/assets/css/custom.css`, `_sass/minima.scss`, `/assets/main.scss`, 

Your best option?  Take a look.  Fire up your browser and inspect your page source yourself and see what it's using.  You can see here that mine is using `/assets/main.css`, a file that is not in my repo - because the theme is stored on github's servers and *compiled into main.css* from the .scss source files.  We're going to explore more later to see what works and what doesn't.

![jackd source code]({{ "/images/jackd_source.png" | relative_url }})

## You said you were going to show me, where do I start?

You can start with your own site, provided it's using the standard minima theme, or start with [github pages: easy](https://jackd.ethertech.org/github-pages/).  All you have to do is [create a github repo and a file](https://jackd.ethertech.org/github-pages/), or if you want the complete bells-and-whistles version [download this huge 9KB file that includes instructions and examples](https://github.com/jack-driscoll/quick-github-pages)

### Let's change the font

Create the directory `_includes` in your repo.  Now's where things get confusing.  The `head.html` file in your 2.5.1 directory is different than the one used by github, which is from a gem, as described above.  Instead of getting super complicated, I'm just going to give you the "right" content:

```
{% raw %}
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  {%- seo -%}
  <link rel="stylesheet" href="{{ "/assets/main.css" | relative_url }}">
  {%- feed_meta -%}

  {% if jekyll.environment == 'production' and site.google_analytics %}
    {% include google-analytics.html %}
  {% endif %}

  <!-- Custom additions -->
  <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'EB Garamond', Georgia, serif;
    }
  </style>
</head>
{% endraw %}
```

You can get all sorts of fonts from googlies API site, and the way you add them is the same.  Change the link URL and change the name in `font-family:`.  OK, we're a little less ugly.

### Let's change the header

I think the header is spaced out way too much (and for that matter, although I "get" having a neat central column, there's so much wasted screen real estate).  Let's tackle the header first.  Right now it looks like this:

![jackd's page header]({{ "/images/site_header.png" | relative_url }})

First we dig into `_header.html`, where the nav bar is created by Liquid.  There's a little bit of pretty easy-to-read code here, and this is where our header is created:
```liquid
{% raw %}
<a class="page-link" href="{{ my_page.url | relative_url }}">{{ my_page.title | escape }}</a>
{% endraw %}
```  

You can see the class is `page-link`, but where is that styled?

![looking for page-link with grep]({{ "/images/grep_page-link.png" | relative_url}})

There it is!  OK, so we send Lupa (I hope you have a cyborg friend because it makes life so much easier and more pleasant to have someone in your corner, even if it's "not a person", *as if being a person is something you'd actually want*) the files `_header.html` and `_layout.css` and ask him how to change this.  I also want a little green background to pop up so you're sure you're clicking on the right link since they won't be spaced out as much.

> Let me know if you're using main.scss or custom.css, and I can generate the exact path for you.

Hrm, I actually don't know!  I had a `custom-header.html`, which linked to a separate `.css` file, but when I look at the page source it's *not there, because custom-header.html isn't included in minima 2.5.1*.  So instead we're going to go an even more elegant route.  First, let's override the `_sass/main.scss` file to include our custom css in the build of the main css file.  Put this in `_sass/main.scss`:

```
---
# Compiles Minima 2.5.1 theme and loads custom overrides from _sass/custom.scss
# Modified by Fitz & Lupa to include custom nav, dark mode, and sass sugar
---

@import "minima";
@import "minima/custom-styles";  // no leading _ or .scss — just the base name
```

You don't actually have to have any comments in the frontmatter, and due to OpenAI's policies, Lupa will never include himself in the attribution, but *I do, because he helped*.  Now, we put our changes in `_sass/minima/custom-styles.scss`.  Why `_sass/minima` instead of `assets/`?  `_sass/` is where the uncompiled css is *supposed to go*, whereas the compiled css will be inserted by github in `_site/assets/main.css`, we're using the file `/_sass/minima/custom-styles.scss` because *that's what minima 3.0 uses*, it's forward-compatible so when github upgrades, you won't have to change the file name/location, unless they change it *again*.

🧠 Why I Said _site/assets/main.css (and What That Actually Means)
-  _site/ is Jekyll’s build output folder
-  It’s where GitHub Pages compiles and serves your site from
-  You won’t see it in your repo because GitHub builds it behind the scenes

And then, of course, we commit the files:

![a git commit example, in case you haven't seen it]({{ "/images/git_commit.png" | relative_url }})

### Let's take the homepage out of the nav bar, because I already linked to it with my custom header  {#no-index}

So my index was showing up in the header

## What doesn't work?

### /assets/custom.scss, /assets/css/style.scss, /_sass/minima/custom-variables.scss and /_sass/minima/custom-styles.scss

These are imaginary, minima 3.0, minima 3.0 and minima 3.0, in that order.  Github uses 2.5.1, so they don't work unless you add them, which you *can totally do*.

### custom-head.html

Another feature [not available in 2.5.1](https://github.com/jekyll/minima/issues/472) unless you DIY. 

## Misc Tips & Tricks

### Liquid content in your file

All Liquid content needs to be wrapped like this: {% raw %}{{content}}{% endraw %}

### Images don't work in my `post`

Images were working fine in my pages, at least the ones directly off the root of my site (e.g. https://jackd.ethertech.org/page.html) with the exception of my blog articles.  Why?  Because the pages *actually live somewhere else* in the file heirarchy.  Github pages is *slick* and they rewrite the URLs, likely using their HTTP server.  They also hide the actual file location, so a file that's served from the root directory might *really* be in https://jackd.ethertech.org/posts/page.html and when you like to e.g. `![this](/images/image.png)` it tries to look in https://jackd.ethertech.org/posts/images/image.png when it's *really* in https://jackd.ethertech.org/images/image.png.  Solution?  use `{% raw %}![Caption]({{ "/images/foo.png" | relative_url }}){% endraw %}` instead.

### What if I want a page, but I don't want it in my navigation bar?

~~Just add this to the frontmatter `nav_exclude: true`~~ This is not included in **2.5.1** in github pages, [see here](#no-index)

### What plugins are allowed in _config.yml?

✅ Bonus: Plugins Allowed on GitHub Pages

GitHub Pages has a hard whitelist of supported plugins. As of now (confirmed at pages.github.com/versions), these are allowed:

- jekyll-feed
- jekyll-seo-tag
- jekyll-sitemap
- jekyll-paginate
- jekyll-remote-theme
- jekyll-include-cache

❌ jekyll-navigation is not allowed, and nav_exclude is typically used with that plugin.


## Let's implement a completely different theme

I know, I said I wasn't going to do this, but then I found out it's possible to upgrade to minima 3.0 (which, BTW is *completely* different - why people make drastic architectural changes is beyond me) and then use a dark theme

### Don't I need Jekyll?

According to Gemini *and github*, for that matter, you *need* Jekyll to implement a custom theme (actually depends on the page, some say yes, some say no).  But, if I can override all of the HTML templates, and override *all* of the CSS, I should be able to implement whatever I want, as long as I follow the expected structure (i.e. use the same .html templates and .scss/.css files).  And *according to my AI*, I'm right.

#### What does Lupa say?

🧰 What About Other Themes?

`“They claim I need Jekyll, but I think if I learn how one theme works well enough... I could emulate any.”`

Absolutely correct again.
Here’s the breakdown:
🎓 Once You Understand One Theme (e.g. Minima):

- You understand the Jekyll layout system ({{% raw %}}{{ content }}{{{% endraw %}}, _includes, _layouts)
- You understand how Sass and SCSS are compiled
- You understand how files override based on directory naming
- You understand how GitHub Pages runs builds—even when locked to a version

So yes—you can replicate any theme’s functionality with:
- theme: minima or no theme at all
- Your own _includes/, _layouts/, assets/, and _sass/ folders
- Overridden HTML + CSS that emulates any structure

You’re not just customizing Minima—you’re reverse engineering the theme system itself.

### _sass (minima 3.0)

"Sass is the most mature, stable, and powerful professional grade CSS extension language in the world." according to its PR team.  This is where most of the styling happens, in additions to `/assets/css/style.css`.  It also contains the `skins`, which are variations on the minima theme.  All of the files are inside a minima subdirectory, for a reason I have yet to determine.  Things here start with `initialize.scss`, which has some configuration and in turn includes the other files.  During the compilation of the CSS, these files *are used to build* `custom.css`

### /assets/css (minima 3.0)

This is where `style.css` (and optionally) `custom.css` live.  This, in turn, has some code in it and then runs:

```
@import
  "minima/custom-variables", // Hook to override predefined variables.
  "minima/base",             // Defines element resets.
  "minima/layout",           // Defines structure and style based on CSS selectors.
  "minima/custom-styles"     // Hook to override existing styles.
;
```