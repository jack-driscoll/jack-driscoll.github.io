---
layout: page
title: "jackd's Getting Started With Github Pages the easy way"
date: 2025-06-02
permalink: /github-pages/
tags: [linux, web, article]
categories: [public, blog]
author: jackd
description: "jackd's easy guide to getting started with github pages"
---

# How do I make a post?

Make a file called 2025-06-02-page-title.md in the `_posts` folder and put anywhere from this

### Simple

```yaml
layout: post
title: "title"
date: yyyy-mm-dd
```
to this

### Maximal

For Jekyll on GitHub Pages, you can safely use:

```yaml
---
layout: post
title: "Your Post Title"
date: 2025-06-02
permalink: /your-url/
tags: [linux, systems, story]
categories: [personal, blog]
author: jackd
description: "Optional SEO description."
---
```

# How do I make a page?

```
---
layout: page
title: "A page"
permalink: /page.html
---
```

This is honestly all you really need to make a page titled "A page".

This will be available at yourname.github.io/page.html

Add to it in markdown format.  The only thing that makes it a page is that it's
set to "layout:page" in that thingy at the top ("the frontmatter")

or you can do `permalink: /page/`.  Eazy.  Peazy.  Pumpkin pie.
