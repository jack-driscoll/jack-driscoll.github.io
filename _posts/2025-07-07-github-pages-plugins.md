---
layout: post
title: "GitHub Pages Allowed Plugins"
date: 2025-07-07
tags: [diy, how-to, guide, github, web, html, css, documentation, jekyll]
permalink: /2025-07-07-github-pages-plugins.html
author: lupa
description: "A brief and concise list of allowed github pages plugins and what they do including custom themes"
---


# ✅ GitHub Pages Allowed Plugins (as of 2025)

These plugins are **pre-installed** and **enabled automatically** by GitHub Pages—no need to add them to a Gemfile or `_config.yml` unless you're doing something custom.

## 🧩 Plugin Capabilities Table

| Plugin                     | What It Does                                                                 |
|----------------------------|------------------------------------------------------------------------------|
| `jekyll-feed`              | Adds an Atom/RSS feed at `/feed.xml` for your posts.                        |
| `jekyll-seo-tag`           | Auto-generates SEO, OpenGraph, and Twitter card meta tags.                  |
| `jekyll-sitemap`           | Builds a full sitemap.xml automatically.                                    |
| `jekyll-gist`              | Lets you embed GitHub Gists with LIQUID IS DRIVING ME NUTS.                              |
| `jekyll-paginate`          | Enables simple blog pagination (split post list into pages).                |
| `jekyll-redirect-from`     | Adds redirect logic via YAML front matter (e.g., `redirect_from:`).         |
| `jekyll-optional-front-matter` | Allows files to be processed without needing `---` front matter.       |
| `jekyll-readme-index`      | Uses `README.md` as the homepage if no `index.md` is present.               |
| `jekyll-default-layout`    | Applies a default layout if none is specified.                              |
| `jekyll-titles-from-headings` | Uses first `<h1>` as page title if front matter `title:` is missing.    |
| `jekyll-relative-links`    | Makes relative links work consistently within repos and folders.            |
| `jekyll-coffeescript`      | Compiles `.coffee` files to JavaScript (mostly legacy).                     |
| `jekyll-commonmark-ghpages`| Enables GitHub-flavored Markdown rendering.                                |
| Built-in Themes (`minima`, `primer`, etc.) | Core themes maintained by GitHub. Only these are supported.  |

---

## ⚠️ Unsupported Plugins (Will Not Work)

These common plugins are **not allowed** on GitHub Pages builds:

- `jekyll-assets`
- `jekyll-navigation` *(often misleading from tutorials!)*
- `jekyll-scholar`
- `jekyll-archives`
- `jekyll-tagging`
- `jekyll-admin`
- Anything that requires a custom Gemfile

To use these, you’d need to set up **GitHub Actions or local builds** that push the `_site/` output manually.

---

## ⚙️ Special Cases

### `jekyll-remote-theme` ✅ *Allowed (but with rules)*

| Feature | Status |
|---------|--------|
| Remote themes | ✅ Supported via `_config.yml` |
| Custom themes | ⚠️ Must be on GitHub public repo, under a proper `theme:` key |

Usage:

```yaml
remote_theme: user/repo
```

Works as long as you’re pulling from a public GitHub-hosted theme repo that follows [Jekyll remote theme guidelines](https://github.com/benbalter/jekyll-remote-theme).

---

### `jekyll-include-cache` ❌ *NOT allowed by GitHub Pages*

This plugin caches ``{% include %}`` results to speed up local builds, but it is **not supported** on GitHub Pages' servers.

If you try to use it, the site will fail to build unless you use a custom CI setup.

---

## ✅ TL;DR

> If it’s **not on the whitelist**, it won’t work on GitHub Pages unless you build your site externally and push the result.
