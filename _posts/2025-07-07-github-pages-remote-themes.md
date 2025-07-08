---
layout: post
title: "GitHub Pages jekyll-remote-them plugin Without Installing Jekyll"
date: 2025-07-07
tags: [diy, how-to, guide, github, web, html, css, documentation, jekyll]
permalink: /2025-07-07-github-pages-remote-themes.html
author: nteleky
description: "A guide to implementing remote custom themes on github pages using jekyll-remote-theme without installing anything, the easiest way to implement cool new themes for your github pages site, by nTeleKy and Lupa"
---

# 📦 `jekyll-remote-theme` – What It Is and How to Use It

`jekyll-remote-theme` is a GitHub Pages–approved plugin that allows you to **use any public GitHub-hosted Jekyll theme** without cloning or copying its files directly into your repo.

---

## ✅ How It Works

Instead of installing a theme via RubyGems, you just add this line to your `_config.yml`:

```yaml
remote_theme: user/repo
```

This tells GitHub Pages to pull the theme from the given GitHub repo on build. The theme must be public and must follow standard Jekyll theme structure.

---

## 🧰 Example

To use Minima 3.0 via remote theme:

```yaml
remote_theme: jekyll/minima
```

Then remove or ignore:

- Any manually copied `_layouts`, `_includes`, `_sass/minima`, or `assets/main.scss`
- Custom overrides should go **after** the remote theme is applied

---

## ⚠️ Important Notes

| Feature                | Supported? |
|------------------------|------------|
| Public GitHub themes   | ✅ Yes     |
| Private repos          | ❌ No      |
| Custom themes (not on GitHub) | ❌ No |
| Local theme override   | ⚠️ Only via file-path matching |
| `_sass`, `_layouts`, etc. | ✅ You can override individual files in your repo |
| `_config.yml` merges   | ✅ Remote theme config is merged with yours |

---

## 🧪 Your Plan vs. Remote Theme

> “I was going to manually copy the SCSS and layout files from Minima 3.0 into my repo and include them in `main.scss`…”

That **will work**, and it’s how you “upgrade” to Minima 3.0 **by force**, but:

### Pros of manual upgrade
- Full control over every file
- No surprises from remote updates

### Cons
- More complex maintenance
- You’ll miss upstream changes unless you re-copy

### ✅ Easier Alternative: `jekyll-remote-theme`

- Use `remote_theme: jekyll/minima`
- Drop in only the files you want to override
- GitHub will always pull the latest compatible version

---

## 🔚 TL;DR

If you want to “upgrade” to Minima 3.0:
- You can copy the raw files into your repo and rewrite `main.scss`
- OR just use `jekyll-remote-theme` and override only what you need

For most users:  
**`remote_theme:` is easier, cleaner, and fully GitHub Pages–compliant.**