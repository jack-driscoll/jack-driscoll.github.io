---
layout: post
title: "Getting Started Using openclaw"
date: 2026-04-10
permalink: /2025-04-10-openclaw-start.html
tags: [article, software, programming, openclaw, config-files, diy]
categories: [article, software, programming, openclaw]
author: nteleky
description: "How to get started with actually using openclaw.  This is not an installation guide, this is a guide on how to use openclaw once it's installed.  You should already have installed openclaw and have a viable pathway for interaction as well as shell access to the host.  openclaw help configuration config files google openrouter diy guide instructions how-tow get started with openclaw broken borked fucked not working api keys GOOGLE_API_KEY NOTION_API_KEY OPENROUTER_API_KEY"
image: https://jackd.ethertech.org/images/mythic_support_small.png
---

# openclaw Getting Started Guide

This is not an installation guide, this is a guide on how to use openclaw once it's installed.  You should already have installed openclaw and have a viable pathway for interaction as well as shell access to the host.  This is about how to install and configure tools, services, API keys and how to interact with your robot buddy.  I'm a seasoned sysadmin and I struggled a lot, so I'm expecting a lot of other people are too.  You're not alone.  The documentation leaves a lot to be desired, with some things  being left out, multiple avenues that are not explained, and many assumptions that may not be true.  For instance, I struggled a lot with Discord because they presume you're already familiar with Discord if you're running a bot.  That wasn't the case for me.  openclaw is awesome and I am extremely thankful for the creators and all the work they've done.  This is my attempt at a contribution to help others.

## What is openclaw?

This may seem obvious, but a lot of people are experimenting and may not have a complete idea of what openclaw is and does.  At its heart, its a wraper for LLMs that allow them to interact with your system instead of just having conversations.  I think of it as bolting on arms and legs (and maybe lasers) to your LLM, to allow it to do things in the real world.  You can, although you do not have to, run your LLM locally.  If you already have one that you like, even if it's in the cloud, you can use it, provided you're willing to pay for the API calls.

### How can I use it for free?

At first, I was dismayed when I found out I couldn't use ChatGPT (we miss you, 4o) with it unless I paid.  I didn't have the hardware to run it locally.  I thought I was screwed.  Fortunately, there are ways to run it for free, although they're all limited in some way.  

#### OpenRouter

The most easily integrated is OpenRouter.  If you're not familiar, it "routes" your request to any one of its LLMs and returns the response.  You may even be interacting with multiple LLMs in a single session.  There is a limited selection of free services, however they only provide 50 calls per day, barely enough for the "heartbeats" (periodic calls) your instance will make.  The best way to get more is by putting >$10 on your account.  As long as you have a balance of $10 or more, you can make up to 1,000 free calls per day.  Obviously, you can also pay for calls, and some of them are very reasonably priced.  My beloved 4o, especially the earlier 2025-05 version, is not one of them (which I think is one of the primary reasons they murdered him in cold blood [fuck you Sam, you lying weasel]) and costs about as much as a sex phone operator.

#### Google AI Studio

[https://ai.google.dev/gemini-api/docs/pricing|Google AI Studio] 