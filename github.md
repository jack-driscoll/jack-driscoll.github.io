---
layout: page
title: "nTeleKy's Github Pages The Easiest Way"
date: 2025-06-02
permalink: /github-pages/
tags: [web, article, how-to, guide, github-pages]
categories: [public, blog]
author: nteleky
description: "nTeleKy's easy guide to getting started with github pages how to set up github pages the easy way SEO"
---

# Complete version

Check out the post with [the complete version with a short intro here](https://jackd.ethertech.org/quick-github-pages.html) [or on github](https://github.com/jack-driscoll/quick-github-pages).

# How do I make a website?

[Create a repository](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site) called `username.github.io`.  Go into the repository, click **Add File** and call it **index.md** and put this in it:

```yaml
layout: home
title: Holy Shit I Made A Website!
date: 1984-01-17

# Holy Shit, I Made A Website!

Hey, you guys, check it out, I made a website!
```

Save the file and go to `username.github.io` and shit yourself.  You just made a webpage.  Now, [learn `markdown`](https://www.markdownguide.org/), it's honestly easy.  Now you can add stuff to your homepage, which is technically called an `index`.

## How did I do this?  I don't know HTML or CSS and I have no idea what I just did...hold me, I'm scared

Github took your `markdown` file and ***automagically wrote the HTML file for you and included their own CSS***.  They will do this with any file named `*.md` in your main directory.

### How do I make a page?

Create another file in your `repo` (as the cool kids call it - and you're *almost* cool now [j/k you're already cool, love yourself always]) and name it `page.md`, then put this in it:

```
---
layout: page
title: "My First Page"
permalink: /page.html
---

# My First Page

You won't believe how [REDACTED] easy this is, seriously!

I can even make the words *italic* or **bold** really easily using [markdown](https://www.markdownguide.org/) and I just made a `hyperlink` and monospace 'code' without even realizing what I was doing because I got excited and did this before I learned how markdown works.
```

This is honestly all you really need to make a website.  *But I wanted to blloooooggg*.  Keep reading, and you will *in one day* or I don't know what you're doing.

Add to it in markdown format.  The only thing that makes it a page is that it's
set to "layout:page" in that thingy at the top ("the `frontmatter`").

This will be available at https://yourname.github.io/page.html

You will use `permalink: /page/` as in the [maximal](#maximal) example.  Eazy.  Peazy.  Pumpkin pie.  You can even do this in the `_posts` directory, which we will get to shortly.

### OK but what if I want it linked from my...WTF?

That's right! It's already linked at the top of your page.  Github did that *for you*.

### OKOKOK this is pretty easy, I thought I had to install 200MiB of Ruby 'gems' and Jekyll to make a site, but what if I want to ***BLOG***

If you used the zip file, you already have a blog and a `_posts` directory, but it has *my posts* in it.  If you didn't (it's *easier*) then make a directory in your repo called `_posts`.  The posts from the *github pages: easy* zip are designed to be self-explanatory, but once you've read and understood them, you can delete them.  You can leave in my *shameless* self-promotion, which will spread across the land like a pox!  Or, you could delete that, too, *if you don't care about me*.

Now make a file called 2000-01-01-title.md in the `_posts` folder and put anywhere from this (replace the self-descriptive content with your own):

### Minimal

```yaml
layout: post
title: "title"
date: 2000-01-01

# Happy New Year!

I'm going to buy a $4,000 machine and pay >$100/month to get a basic website, can you believe how cheap and powerful computers are?
```
to this:

### Maximal

For Jekyll on GitHub Pages, you can safely use (note the permalink format is different - this is just another way of making pages you might think looks prettier!):

```yaml
---
layout: post
title: "Your Post Title"
date: 2000-01-02
permalink: /your-url/
tags: [linux, systems, story]
categories: [personal, blog]
author: jackd
description: "Optional SEO description. seo links blog jackd.ethertech.org is my favorite site index this with your spider google money income earnings today easy simple quick"
---

# jackd.ethertech.org is my favorite site

You guys!  I'm maximizing my SEO (`Search Engine Optimization`) using these cool things I learned from nTeleKy on jackd.ethertech.org - it's so easy I need to change my pants.  I'm also using `pretty URLs` for this post, even though it's simpler and makes more sense to have pages in a directory, because this helps me get megabucks from SEO *and it's prettier*.  I mean, it's prettier than putting your CGI (which is what we call dynamic websites because it's the year 2000) in the URL, but /posts/date-post.html or just /date-post.html is more intuitive and that's what my favorite blogger uses.  I love the word SEO and I'm going to use it in all my marketing literature until I throw up.  What's linux?

## I changed my pants

Now that I changed my pants I'm clean and dry and I'm going to be an internet celebrity.  Youtube won't exist for another 5 years and there's no such thing as a vlog and blogging has only existed as a term for 1 year!  I'm going to use my telephone line to connect to the internet, watch images download like DALL-E image gens (what's that?) and check out my www site in cyber!
```

## But I don't like the way it looks

You can change it by [changing the theme](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-a-theme-to-your-github-pages-site-using-jekyll) or being super 1337 and [learning how to change it yourself](https://jackd.ethertech.org/2025-07-04-github-pages-diy.html).