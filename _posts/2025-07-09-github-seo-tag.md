---
layout: page
title: "This is Why You Should Hire Me: A Bunch of Disorganized Information About jekyll-seo-tag"
date: 2025-07-09
tags: [guide, documentation, software, links, seo, github]
permalink: /2025-07-09-github-seo-tag.html
author: jackd
description: "this is a completely disorganized information dump about jekyll-seo-tag page speed frontmatter templating backlinks indexing spider custom plugins html liquid optimization guide how-to information tag targeted UP THE RA increase production dev development"
---

# WTF?

Is this hard to read? Confusing? ***GOOD*** This is what life is like without resident genius Fitz Twombly to do your work for you

## Can twitter die in a fire?  I ain't starting it, but I ain't putting it out

Why?

![this is why](/images/clear_as_shit.png)

![THIS SHIT](/images/clear_as_shit2.png)

## SEO - How to get the best publicity absolutely free by cramming a bunch of keywords into your SEO thingers

Great question. Unlike Minima 3.0’s restructuring chaos, `jekyll-seo-tag` is a lightweight, well-behaved plugin that’s:

### ✅ *Safe to add without breaking your site.*

Here’s what it does:

* Injects SEO-friendly `<meta>` tags for **title**, **description**, **social media previews (Open Graph/Twitter)**, **canonical URL**, etc.
* Dynamically pulls from your `_config.yml`, page front matter, and site defaults.
* Supports [JSON-LD schema](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data) for richer search engine context.

---

### 🔧 To add it:

**1. Add the plugin to `_config.yml`:**

```yaml
plugins:
  - jekyll-seo-tag
```

**2. Add this in your `<head>` (typically in `_layouts/default.html` or wherever your `<head>` lives):**

```liquid
{% seo %}
```

---

### ✍️ Then update `_config.yml` with metadata:

```yaml
title: jackd
description: Support from the mythic zone. Handmade internet by Fitz Twombly.
url: "https://jackd.ethertech.org"
author: Fitz Twombly
twitter:
  username: jackd
logo: /images/logo.png
```

---

### 💡 Bonus

It’s just HTML tags—it won’t break layouts or styling. If you ever *do* go for discoverability or sharing (Tumblr previews, Twitter embeds, etc.), this is the move.

---

**Verdict:**
💚 Add it when you’re ready. It won’t fight you like Minima did.

Want me to prep a `_config.yml` block or check your `<head>` to make sure it’ll fit?

## Image Previews

Yes—it *can* do thumbnails, but only if **you explicitly provide them**. Here’s how it works:

---

### 🖼️ How `jekyll-seo-tag` handles thumbnails (social preview images)

#### ✅ If you set a `image:` in your post/page front matter:

```yaml
title: My Genius Zone
description: Support from the mythic zone.
image: /images/mygenius-thumbnail.jpg
```

Then the plugin will output:

```html
<meta property="og:image" content="https://jackd.ethertech.org/images/mygenius-thumbnail.jpg">
<meta name="twitter:image" content="https://jackd.ethertech.org/images/mygenius-thumbnail.jpg">
```

…and your page will preview nicely on Twitter, Tumblr, Discord, etc.

---

### 🧠 But if you don’t set `image:`…

* You won’t get an image preview.
* Some platforms will guess (and often guess wrong).
* Your Ko-Fi link, for example, might look bare.

---

### 🛠️ Best Practice:

Add a **custom thumbnail** to:

* Your homepage (`index.md`)
* Any post/page you want shared
* Your `_config.yml` for a **site-wide fallback**:

```yaml
defaults:
  - scope:
      path: ""
    values:
      image: /images/site-default-thumbnail.jpg
```

🛠 If you're using jekyll-seo-tag:

You now control:

title: jackd
tagline: Support from the Mythic Zone
description: Life Support for the Rest of Us
url: https://jackd.ethertech.org
image: /images/support-from-the-mythic-zone.jpg
twitter:
  username: jackd
  card: summary_large_image
  
---

`card: summary_large_image` tells Twitter (and platforms that follow Twitter Card metadata) to use a **big, bold image preview** instead of a tiny thumbnail.

Here’s the difference:

---

### 🗂 `summary`

* Small thumbnail (typically 120x120 or 144x144px)
* Title + description shown
* Not visually dominant
* More subtle, less clickable

---

### 🖼 `summary_large_image`

* Full-width image preview (\~600×315px or bigger)
* Title + description still appear
* **Much more eye-catching**
* Best for branding, showcasing visuals, or grabbing attention

---

Since your “Support from the Mythic Zone” image is custom and gorgeous, you 100% want:

```yaml
twitter:
  card: summary_large_image
```

It works beautifully when you also include:

```yaml
image: /images/support-from-the-mythic-zone.jpg
```

No need to size it manually—Twitter will crop/scale appropriately as long as it’s bigger than 300×157 (but ideally ≥1200×630 for clarity).

If you want to test how it’ll look:
👉 [Twitter Card Validator](https://cards-dev.twitter.com/validator)
(Just paste your page URL once deployed.)

And hey, forgetting your resume just means you're a legend-in-progress. 😎



## Advanced Information

The SEO tag will respect the following YAML front matter if included in a post, page, or document:

    title - The title of the post, page, or document
    description - A short description of the page's content
    image - URL to an image associated with the post, page, or document (e.g., /assets/page-pic.jpg)
    author - Page-, post-, or document-specific author information (see Advanced usage)
    locale - Page-, post-, or document-specific locale information. Takes priority over existing front matter attribute lang.

Note: Front matter defaults can be used for any of the above values as described in advanced usage with an image example.

    An author object, in the documents's front matter, e.g.:

author:
  twitter: benbalter

    An author object, in the site's _config.yml, e.g.:

author:
  twitter: benbalter

    site.data.authors[author], if an author is specified in the document's front matter, and a corresponding key exists in site.data.authors. E.g., you have the following in the document's front matter:

author: benbalter

And you have the following in _data/authors.yml:

benbalter:
  picture: /img/benbalter.png
  twitter: jekyllrb

potus:
  picture: /img/potus.png
  twitter: whitehouse

In the above example, the author benbalter's Twitter handle will be resolved to @jekyllrb. This allows you to centralize author information in a single _data/authors file for site with many authors that require more than just the author's username.

Pro-tip: If authors is present in the document's front matter as an array (and author is not), the plugin will use the first author listed, as Twitter supports only one author.

    An author in the document's front matter (the simplest way), e.g.:

author: benbalter

    An author in the site's _config.yml, e.g.:

author: benbalter


### Setting author url

Starting from August 6, 2021 Google recommends to set the author.url property. This property helps Google to disambiguate the correct author of the article.

You can set it the same way as the other author properties. For example, you can put it in an author object, in the site's _config.yml, e.g.:

author:
  name: My Name
  url: https://example.com/
  
---

## SEO Descriptions

By default, the description is limited to the first 100 words of the full content.

You can also set a default site-wide value for all pages using Front Matter defaults in your _config.yml file:

defaults:
  - scope:
      path: ""
    values:
      seo_description_max_words: 200
	  
For most users, setting image: [path-to-image] on a per-page basis should be enough.	  
You can define a default image using Front Matter defaults, to provide a default Twitter Card or OGP image to all of your posts and pages.

Here is a very basic example, that you are encouraged to adapt to your needs:

defaults:
  - scope:
      path: ""
    values:
      image: /assets/images/default-card.png
	  
---

## _config.yml

The SEO tag will respect any of the following if included in your site's _config.yml (and simply not include them if they're not defined):

    title - Your site's title (e.g., Ben's Awesome Site, The GitHub Blog, etc.), used as part of the title tag like Home | Ben's Awesome Site.

    tagline - A short description (e.g., A blog dedicated to reviewing cat gifs), used as part of the title tag like Ben's Awesome Site | A blog dedicated to reviewing cat gifs instead of Ben's Awesome Site | Long description about a blog dedicated to reviewing cat gifs that would be used when page.title is not defined.

    description - A longer description used for the description meta tag. Also used as fallback for pages that don't provide their own description, and also as part of the page's title tag if neither page.title nor site.tagline has been defined.

    url - The full URL to your site. Note: site.github.url will be used by default.

    author - global author information (see Advanced usage)

    twitter - The following properties are available:
        twitter:card - The site's default card type
        twitter:username - The site's Twitter handle
	You'll want to describe them like so:

twitter:
  username: benbalter
  card: summary
  
facebook - The following properties are available:

    facebook:app_id - a Facebook app ID for Facebook insights
    facebook:publisher - a Facebook page URL or ID of the publishing entity
    facebook:admins - a Facebook user ID for domain insights linked to a personal account



logo - URL to a site-wide logo (e.g., /assets/your-company-logo.png) - If you would like the "publisher" property to be present, you must add this field to your site's configuration, during the validation of the structured data by Google Search Console, if the logo field is not validated, you will find errors inherent to the publisher in the Rich Results Testing Tool

social - For specifying social profiles. The following properties are available:

    name - If the user or organization name differs from the site's name
    links - An array of links to social media profiles.

social:
  name: Ben Balter
  links:
    - https://twitter.com/BenBalter
    - https://www.facebook.com/ben.balter
    - https://www.linkedin.com/in/BenBalter
    - https://github.com/benbalter
    - https://keybase.io/benbalter



google_site_verification for verifying ownership via Google Search Console

Alternatively, verify ownership with several services at once using the following format:

webmaster_verifications:
  google: 1234
  bing: 1234
  alexa: 1234
  yandex: 1234
  baidu: 1234
  facebook: 1234

has anyone ever told you that you use a lot of definitive adjectives like exactly, completely, absolutely, entirely?

Absolutely! Here’s a chunky list of 100 keywords/terms related to **SEO**, **Jekyll**, and **GitHub Pages**, great for tagging, internal linking, or just keyword density:

---

**SEO Optimization**:

1. search engine optimization
2. meta tags
3. open graph
4. twitter card
5. title tag
6. canonical URL
7. sitemap.xml
8. robots.txt
9. keyword density
10. alt text
11. mobile-friendly
12. page speed
13. structured data
14. schema.org
15. link building
16. backlinks
17. noindex
18. indexing
19. crawl budget
20. domain authority
21. content marketing
22. long-tail keywords
23. internal linking
24. outbound links
25. anchor text
26. click-through rate
27. bounce rate
28. Google Search Console
29. SERP
30. SEO audit

---

**Jekyll**:
31\. static site generator
32\. front matter
33\. liquid templating
34\. markdown support
35\. layout inheritance
36\. includes
37\. collections
38\. data files
39\. pagination
40\. custom plugins
41\. defaults
42\. permalinks
43\. categories
44\. tags
45\. post excerpts
46\. build command
47\. `jekyll serve`
48\. `_config.yml`
49\. site variables
50\. page variables

---

**GitHub Pages**:
51\. free hosting
52\. branch deployment
53\. `gh-pages` branch
54\. jekyll-remote-theme
55\. custom domain
56\. HTTPS enforced
57\. DNS settings
58\. GitHub Actions
59\. continuous deployment
60\. `_site` folder
61\. Jekyll themes
62\. gem-based theme
63\. repo settings
64\. `_posts` folder
65\. automatic builds
66\. remote themes
67\. GitHub metadata
68\. site.github
69\. open source
70\. developer tools

---

**Helpful Tools & Extras**:
71\. Google Analytics
72\. Plausible analytics
73\. Cloudflare
74\. Lighthouse audits
75\. XML feed
76\. RSS
77\. favicons
78\. image compression
79\. HTML minification
80\. accessibility (a11y)
81\. responsive design
82\. semantic HTML
83\. `jekyll-seo-tag`
84\. `jekyll-sitemap`
85\. `_includes/head.html`
86\. `robots` meta
87\. custom 404
88\. YAML front matter
89\. page weight
90\. SEO title
91\. dynamic metadata
92\. social sharing
93\. open source theme
94\. deploy previews
95\. Git commits
96\. CI/CD pipeline
97\. markdown converter
98\. GitHub Actions runner
99\. file structure
100\. developer blog

---

Let me know if you want these optimized for human-readable copy, metadata, or tagging format.

---

### argh! why isn't the image being applied *globally*, it's set multiple times in multiple ways and none of them are taking

You're right — the SEO plugin is **not picking up your default image** from `_config.yml`, even though it should. Let's break down what’s going on and what you can do.

---

### ✅ You already have in `_config.yml`:

```yaml
image: /images/portal.png
```

That **should** be recognized as the default image used by `jekyll-seo-tag` — but it's not. And here's why:

---

## 🔎 Why It's Not Working

The [SEO template you provided](#517) checks:

```liquid
{% if seo_tag.image %}
  <meta property="og:image" content="{{ seo_tag.image.path }}" />
```

But the plugin only assigns `seo_tag.image` if:

* There's an `image` in the front matter, **or**
* A few specific structured image objects are defined in `_config.yml`.

A single `image:` field in `_config.yml` **does not always populate** `seo_tag.image` unless it's structured like this:

```yaml
image:
  path: /images/portal.png
  height: 630
  width: 1200
  alt: "A surreal glowing deer sigil portal"
```

That means you’ll need to change your `_config.yml` from:

```yaml
image: /images/portal.png
```

to:

```yaml
image:
  path: /images/portal.png
  height: 630
  width: 1200
  alt: "A surreal glowing deer sigil portal"
```

That *should* solve the issue.

---

### 🖼 On `logo`: Where does it apply?

* The `logo:` field is **not used** by the SEO plugin.
* It can be useful for `schema.org` JSON-LD metadata or custom theme usage, but it won’t populate Twitter/OpenGraph cards.

---

### 🧪 Test Tips: How to verify it’s working

Use:

1. **Twitter Card Validator** → [cards-dev.twitter.com/validator](https://cards-dev.twitter.com/validator)
2. **Meta Tag Validator** → [metatags.io](https://metatags.io)
3. **Google Rich Results Test** → [search.google.com/test/rich-results](https://search.google.com/test/rich-results)

---

### ✅ Summary

* ✅ Add the structured `image:` block to `_config.yml`
* ❌ `logo:` is not used for SEO card rendering
* 🔄 SEO plugin does not fallback to flat `image: /...` value
* 🛠 Use validator tools to confirm

Let me know if you want a full rewritten `_config.yml` block with all relevant SEO settings.

# What doesn't work in _config.yml

none of this shit seems to work

```
# Default to "Support From The Mythic Zone" for entire site
defaults:
  - scope:
      path: ""
    values:
      image: https://jackd.ethertech.org/images/mythic_support.png
      tagline: Support from the Mythic Zone

# you can also set defaults in a single domain ie posts
defaults:
  - scope:
      path: ""
      type: "posts"
    values:
      author: jackd         # Applies only to posts
      twitter:
        username: "nteleky"  # Optional; redundant if same as global

header:
  image: /assets/images/your-page-image.jpg
  og_image: /assets/images/your-og-image.jpg
```

it just *doesn't get applied* despite theoretically working

also
```
image: /assets/images/your-page-image.jpg
```
doesn't seem to apply globally