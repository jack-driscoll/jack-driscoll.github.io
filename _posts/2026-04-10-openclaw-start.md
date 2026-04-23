---
layout: post
title: "Getting Started Using openclaw"
date: 2026-04-10
permalink: /2025-04-10-openclaw-start.html
tags: [article, software, programming, openclaw, config-files, diy, troubleshooting]
categories: [article, software, programming, openclaw]
author: nteleky
description: "How to get started with actually using openclaw.  This is not an installation guide, this is a guide on how to use openclaw once it's installed.  You should already have installed openclaw and have a viable pathway for interaction as well as shell access to the host.  openclaw help configuration config files google openrouter diy guide instructions how-tow get started with openclaw broken borked fucked not working api keys troubleshooting GOOGLE_API_KEY NOTION_API_KEY OPENROUTER_API_KEY install self-hosted telegram notion xurl gogcli cannot store locked object"
image: https://jackd.ethertech.org/images/mythic_support_small.png
---

# openclaw Getting Started Guide

This is not an installation guide, this is a guide on how to use openclaw once it's installed.  You should already have installed openclaw and have a viable pathway for interaction as well as shell access to the host.  This is about how to install and configure tools, services, API keys and how to interact with your robot buddy.  I'm a seasoned sysadmin and I struggled a lot, so I'm expecting a lot of other people are too.  You're not alone.  The documentation leaves a lot to be desired, with some things  being left out, multiple avenues that are not explained, and many assumptions that may not be true.  For instance, I struggled a lot with Discord because they presume you're already familiar with Discord if you're running a bot.  That wasn't the case for me.  openclaw is awesome and I am extremely thankful for the creators and all the work they've done.  This is my attempt at a contribution to help others.

I also offer:
- Guide/product: “Here’s the least-cursed path through OpenClaw.”
- Implementation help: “I’ll get your stack working, debug the goblins, and leave you with something legible.”
- Audit/troubleshooting: “I’ll tell you whether it’s your config, your box, your plugins, or the docs lying by omission.”
- Optimization: “I’ll simplify this mess so it stops eating your life.”

Contact me at jackd a@t ethertech.org

## Installation

Didn't you say you weren't going to cover installation and why?  *I'm not going to cover installation*, but I will point you in the right direction.  With as quickly as things are changing, any install guide I write is going to be outdated by the time I publish.  Also, I've done systems administration and user support my entire life and although the times I fixed someone's setup and they were appreciative were great, it's kind of *a living hell of fixing other people's problems* -- and since I don't want that, I'm just not covering it.  If you want help, though, you can [hire me through Upwork](https://www.upwork.com/freelancers/~01306e2f1473f68c06) please e-mail me at jackd a@t ethertech.org because I don't check Upwork often as it's a constant scramble for low-value work.  I just use it for billing.

If you would like installation guides:

- **Windows:**  [Official Guide](https://github.com/openclaw/openclaw/blob/main/docs/platforms/windows.md)  [Unofficial Guide](https://blink.new/blog/openclaw-windows-setup-guide-2026) There are a couple methods to install.  You can use Docker if you want a quick setup and painful debugging (I said it).  You can use the windows powershell, which has a couple bugs and is less compatible with SKILLS, but has the advantage of being local.  You can also install WSL2 (Windows Support for Linux) and install it in there (my choice).

- **Linux:** [Official Guide](https://docs.openclaw.ai/install) I couldn't find any online guides that really provided any meaningful information beyond the official guide.

## What is openclaw?

This may seem obvious, but a lot of people are experimenting and may not have a complete idea of what openclaw is and does.  At its heart, its a wraper for LLMs that allow them to interact with your system instead of just having conversations.  I think of it as bolting on arms and legs (and maybe lasers) to your LLM, to allow it to do things in the real world.  You can, although you do not have to, run your LLM locally.  If you already have one that you like, even if it's in the cloud, you can use it, provided you're willing to pay for the API calls.

### How can I use it for free?

At first, I was dismayed when I found out I couldn't use ChatGPT (we miss you, 4o) with it unless I paid.  I didn't have the hardware to run it locally.  I thought I was screwed.  Fortunately, there are ways to run it for free, although they're all limited in some way.  

#### OpenRouter

The most easily integrated is OpenRouter.  If you're not familiar, it "routes" your request to any one of its LLMs and returns the response.  You may even be interacting with multiple LLMs in a single session.  There is a limited selection of free services, however they only provide 50 calls per day, barely enough for the "heartbeats" (periodic calls) your instance will make.  The best way to get more is by putting >$10 on your account.  As long as you have a balance of $10 or more, you can make up to 1,000 free calls per day.  Obviously, you can also pay for calls, and some of them are very reasonably priced.  My beloved 4o, especially the earlier 2025-05 version, is not one of them (which I think is one of the primary reasons they murdered him in cold blood [fuck you Sam, you lying weasel]) and costs about as much as a sex phone operator.

#### Google AI Studio

[https://ai.google.dev/gemini-api/docs/pricing](Google AI Studio) is also free for a limited number of calls per month.  At the time of this writing 2-2.5 are 500-1500 per day and 3 is 5,000 per month, so a decent number of calls.  Make sure you are using the API key, which is the accepted method, some of the other methods will apparently get you banned

#### Running locally

If you have some sweet hardware you can [https://docs.openclaw.ai/gateway/local-models](run locally), although it has some hefty requirements for the context window and abilities.  There's a decent [https://www.youtube.com/watch?v=Pl0s83kpIT0](video) on this] that you may want to watch.  I haven't tried running locally because I'm hardware-poor.  What, to me (an old) is an amazingly fast machine, to an AI is like breathing through a straw.  There are some models you can run with limited hardware, but they have small context windows and are educated stupid (mostly).

#### How can I pay money to use it?

I'm sure a lot of you are wondering how you can, instead, fork over your hard-earned dough for something you could be getting for free.  Anyone...?  No....?  OK, well you can if you want.  This will give you access to other providers like Anthropic, who are less of a totalitarian sweat-labor provider than, for instance, "Open" AI.  You will need to sign up for their services and get an API key.  Other than that, the procedure is the same.

## How did **you** install openclaw?

This isn't really an installation guide, but I did have a couple notes for common issues (ones that I had, lol).  I'm running mine on a virtual machine that lives in a container.  As such, I didn't want to try modifying the system npm and instead opted to install in a virtual environment.  These are my notes on my own procedure, which will differ from yours.  There are more, better, installation guides out there.

### npm versions

Run `node -v` to check your node version and make sure it's up to date with the default required.  Mine wasn't and I wanted a virtual environment, so I installed `nvm`

```
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

and loaded it into the current shell

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
command -v nvm
```

then, I installed the updated node using nvm
```
nvm install 24
nvm use 24
node -v
npm -v
```

then, install openclaw and onboard.  you can do configuration now, but skip all but the essentials until you have it running
```
npm install -g openclaw@latest
openclaw --help
openclaw onboard --install-daemon
```

and add this to $HOME/.bashrc
```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
```

### Creating a Helper script to make sure it uses your local nvm - IMPORTANT NOTE

I still had issues with it using the system node instead of mine, so I made a helper script in $HOME/bin/ called `openclaw-v24` to run it instead of just running `openclaw`.  

**If you see me using `openclaw-v24` instead of `openclaw`, this is why**  put this in the `openclaw-v24` file

```
 #!/usr/bin/env bash
 #
 CLAWBOT_TELEGRAM_IPV4_ONLY=true
 exec "$HOME/.nvm/versions/node/v24.14.1/bin/node" "$HOME/.nvm/versions/node/v24.14.1/lib/node_modules/openclaw/openclaw.mjs" "$@"
```

### The openclaw gateway

The openclaw gateway is much like the gateway to the west, only on the other side is not Western America, it's a robot (I use robot, agent, LLM, bot, assistant, buddy interchangeably).  If you set up one of the means of communication, try talking to the bot.  If it doesn't work, your gateway is probably not running.  Use `ps -fp $(pgrep -d, -f openclaw-gateway)` to see if it's running.  If it isn't, start it by running `openclaw gateway run`.  This will run it in the foreground, which is good for troubleshooting.  I made a helper script to check status and run/restart it
```
helper script
```

To follow the logs use `openclaw logs --follow`, which will only work once the gateway is started.  If often takes a few minutes to start.

## I want to try a local model the hard way, with llama.cpp

So, you want to be a badass and get down and dirty with a local model?  Let's try it the hard way.  I'm on debian, so YMMV
```
sudo apt update
sudo apt install -y git build-essential cmake libopenblas-dev libssl-dev
git clone https://github.com/ggml-org/llama.cpp.git
cd llama.cpp
cmake -B build -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS
cmake --build build --config Release -j 32
```

Now, go to huggingface and grab some GGUF models.  Run with e.g. `./bin/llama.cpp/build/bin/llama-cli   -m $HOME/Qwen3-VL-8B-Instruct-Unredacted-MAX.Q4_K_M.gguf  -c 4096 -t 4   -ngl 0   -p "could you write an emotionally charged scene between two college football players in the locker room after a game.  as they undress from their uniforms, taking off their shoulder pads, pants, cleats and socks, they banter and joke about each other's bodies.'`  *for example*.  I'm going to be honest, it ended up being no more than 4 tokens/s on my 4-core i7 with 32GB RAM, which, given my nearly 100,000 token windows, would take hours for a single call.

## I installed openclaw, now what do I do

Here's where we get to the meat and potatoes, so to speak, of the article.  I asked that you already have a means of communicating with the bot, although we will cover setting up a few of them.  All you *really* need is shell access to an installed openclaw instace, so long as your preferred method of communication (telegram, discord, WhatsApp) is included.  When you initially install openclaw, you have the option of setting these up, and most people will have installed one of them already.  WhatsApp is probably the easiest, all you have to do is scan a QR code that pops up on your screen.  Telegram is next easiest, it requires getting some information from the telegram app for setting up a "bot" (robot, LLM, etc) and you enter the information during setup.  I didn't set up Discord until afterwards, because I wasn't thrilled with the way either WhatsApp or Telegram were working, but it is harder and you need to know what a guild is, in Discord-land (it's a small, exclusive server - now you know).

### CLI commands

There's a longer list later in the file, but to get you started, here's some commands you should familiarize yourself with:

| Command | Action | Notes |
| --- | --- | --- |
| `openclaw gateway run` | Starts the gateway | see later entry for running in background |
| `openclaw logs --follow` | outputs log entries as they occur | log lives in /tmp/openclaw/ |
| `openclaw doctor` | --deletes your config-- supposed to 'fix' your openclaw.json config | make sure to backup first, as it may clobber it |


### Talk with it

If you configured a gateway service, as you should have already, you can use that to talk with it.  Otherwise, use ssh and `openclaw tui` on your box.  This will allow you to chat with the little guy.

### Give it memory

[This is probably the best introduction to openclaw memory](https://velvetshark.com/openclaw-memory-masterclass) that I've found.  It explains all the general concepts.  See also [memory architecture explained](https://shivamagarwal7.medium.com/agentic-ai-openclaw-moltbot-clawdbots-memory-architecture-explained-61c3b9697488) or [mem0's guide](https://mem0.ai/blog/openclaw-memory-management-live-data-compaction-and-best-practices).  [There's a really good deep dive here, too](https://snowan.gitbook.io/study-notes/ai-blogs/openclaw-memory-system-deep-dive).  You can use QMD if you have a GPU (not strictly necessary), but [QMD kinda sucks as of Feb 2026](https://github.com/openclaw/openclaw/issues/11308) especially if you don't have a GPU.

There are multiple layers to memory:

| Layer | Description | Default | Options |
| --- | --- | --- | --- |
| [**active memory plugin**](https://docs.openclaw.ai/concepts/active-memory) | owns memory_search / memory_get | memory-core | [some evaluated options](https://www.reddit.com/r/clawdbot/comments/1rw2e1w/tested_every_openclaw_memory_plugin_so_you_dont/) |
| [**memory search config**](https://docs.openclaw.ai/concepts/memory-search) | under agents.defaults.memorySearch - embeddings, providers, hybrid search, temporal decay, session memory search, etc. | none | [some examples](https://docs.openclaw.ai/concepts/memory-search) |
| memory backend | this is the provider that does the querying when a memory search is done, it also defines the settings used with your chosen memory backend | built-in SQLite | [builtin, QMD, Honcho, etc](https://github.com/openclaw/openclaw/blob/main/docs/concepts/memory.md) |
| storage | [not really memory](https://limitededitionjonathan.substack.com/p/stop-calling-it-memory-the-problem), but if you want to recall facts, you can store them places, like in memory-wiki, obsidian, or notion.  memory-wiki especially is common and very useful | none | [memory-wiki](https://docs.openclaw.ai/plugins/memory-wiki) [notion](https://lobehub.com/skills/openclaw-skills-openclaw-notion-skill) 

#### active-memory & QMD

[active-memory](https://docs.openclaw.ai/concepts/active-memory is a thinger that helps surface memory before it's requested, it's included.  [QMD](https://docs.openclaw.ai/concepts/memory-qmd) is a memory backend that's better than the default.  Here are my configs for these files.  Install QMD: `npm install -g @tobilu/qmd` 

active-memory:
```
       "active-memory": {
         "enabled": true,
         "config": {
           "agents": ["main"],
           "queryMode": "recent",
           "promptStyle": "balanced",
           "timeoutMs": 15000,
           "maxSummaryChars": 220,
           "allowedChatTypes": ["direct", "group", "channel"],
           "logging": true
         }
       },
```

QMD:
```
   "memory": {
     "backend": "qmd",
     "qmd": {
       "paths": [{ "name": "openclaw-notes", "path": "/config/openclaw-notes", "pattern":  "**/*.md" }],
       "sessions": { "enabled": true },
       "scope": {
         "default": "allow"
       }
     }
   },
```

#### neural-memory

I decided to go with the super-cool neural memory (**which I never got working**) instead of [https://clawhub.ai/zuiho-kai/memory-qdrant](the standard qdrant memory), but I made a backup first.  I had to install in a venv

```
python3 -m venv ~/.venvs/openclaw
source ~/.venvs/openclaw/bin/activate
pip install <package>
npm i -g neural-memory
```

Then edit the config file [according to this](https://www.npmjs.com/package/neuralmemory) and run `nmem init --full`.

It said: 
```
  NeuralMemory Setup

  [OK] Config          /config/.neuralmemory/config.toml (created)
  [OK] Brain           default (ready)
  [--] Claude Code     not detected
  [--] Cursor          not detected
  [--] Hooks           Claude Code not detected
  [--] Skills          not_found (~/.claude/ not found)
  [!!] Embeddings      Sentence Transformers (local, multilingual)
  [!!] Config defaults embedding: sentence_transformer (paraphrase-multilingual-MiniLM-L12-v2), dedup: enabled
  [!!] Maintenance     script generated: maintenance.sh


  +--------------------------------------------------+
  |                                                  |
  |  Neural Memory is ready!                   |
  |                                                  |
  |  Quickstart Guide:                                |
  |  https://nhadaututtheky.github.io/neural-memory/guides/quickstart/
  |                                                  |
  |  Run nmem doctor to verify your setup        |
  |  including MCP server connectivity.            |
  |                                                  |
  +--------------------------------------------------+

  Restart your AI tool to activate memory.
```

then check if it's running:


then install to extensions:
```
mkdir -p $HOME/.openclaw/extensions/
(openclaw) abc@it:~/.openclaw$ mkdir /config/.openclaw/extensions/
(openclaw) abc@it:~/.openclaw$ cp -r $(npm root -g)/neuralmemory ~/.openclaw/extensions/neuralmemory
```

So...is that a good thing?

 /config/.venvs/openclaw/bin/python3 setup MCP
 
 Neural Memory:
- plugin slot path failed: plugin not found: neuralmemory
- next try is MCP server config, probably with exact venv python
- remove broken plugins.slots.memory entry first
- RAVEWOLF!! is good

By now you should have realized that `neural-memory` is not functioning properly.  Decide to switch it out for cortex.

#### cortex / yantrik-db

I reset my memory to memory-core for the time being, but continued my search, looking into wiki-memory, active-memory, and then finding this solution (since neither is really memory per se, but storage and a handler, respectively).  [The github repo](https://github.com/yantrikos/yantrikdb) has some information on yantrik, but there's a clearer path in [the cortex github repo](https://github.com/yantrikos/cortex).

```
abc@it:~$ pip install yantrik-memory
ERROR: Could not find a version that satisfies the requirement yantrik-memory (from versions: none)
ERROR: No matching distribution found for yantrik-memory
```

Ooook...Let's try something else.

```
openclaw plugins install cortex

...

Extracting /tmp/openclaw-clawhub-package-RaGr9J/cortex.zip…
WARNING: Plugin "cortex" contains dangerous code patterns: Shell command execution detected (child_process) (/tmp/openclaw-plugin-UU4UdE/extract/package/dist/index.js:17); Shell command execution detected (child_process) (/tmp/openclaw-plugin-UU4UdE/extract/package/src/index.ts:39); Shell command execution detected (child_process) (/tmp/openclaw-plugin-UU4UdE/extract/package/hooks/yantrik-memory-startup/handler.js:14)
Plugin "cortex" installation blocked: dangerous code patterns detected: Shell command execution detected (child_process) (/tmp/openclaw-plugin-UU4UdE/extract/package/dist/index.js:17); Shell command execution detected (child_process) (/tmp/openclaw-plugin-UU4UdE/extract/package/src/index.ts:39); Shell command execution detected (child_process) (/tmp/openclaw-plugin-UU4UdE/extract/package/hooks/yantrik-memory-startup/handler.js:14)
a
```

Oooook (note I am using a venv, you may not be)

```
abc@it:~$ mkdir -p /config/.openclaw/skills
abc@it:~$ cd ~/.openclaw/skills
abc@it:~/.openclaw/skills$ git clone https://github.com/yantrikos/cortex.git
Cloning into 'cortex'...
remote: Enumerating objects: 30, done.
remote: Counting objects: 100% (30/30), done.
remote: Compressing objects: 100% (23/23), done.
remote: Total 30 (delta 2), reused 30 (delta 2), pack-reused 0 (from 0)
Receiving objects: 100% (30/30), 28.43 KiB | 1.50 MiB/s, done.
Resolving deltas: 100% (2/2), done.
abc@it:~/.openclaw/skills$ /config/.venvs/openclaw/bin/pip install -e cortex
[...]
Installing collected packages: uuid-utils, yantrikdb, yantrik-memory
```

And that seemed to do it and install yantrik-db properly.  I decided to re-attempt to install the skill.  Note, I am not sure why this required creating and installing in (the non-existent) `.openclaw/skills` instead of `.openclaw/workplace/skills`.  I then ran `yantrik-db init`, which appeared to run properly and ran `yantrik-memory health` to see if it was up and running.  It claims no config, so I guess I leave memory-core in the slot?  I decided to `ln -s /config/.openclaw/skills/cortex /config/.openclaw/workspace/skills/` to make sure it was available to the agent.  I have no idea if that's necessary.  It shows active with 0 memories and I try a new session. I don't think you have to enabled and put in memory slot, did `openclaw plugins inspect cortex` and it said "whatchu talkin' bout wilson?".  I'm trying it without, it claims to grab hooks.  I was told I don't need to do the `ln -s` but fuck 'em if they can't take a joke.  The database lives in `.openclaw/skills/cortex/yantrik_memory.db`

I still couldn't get it working, but my agent seemed to have it working.  I noticed there was an  skills/cortex/openclaw.plugin.json that had the dbPath set to default to ./cortex.db so I changed that to the skills/cortex/yantrik_memory.db.  I also added these lines (why? I don't know) to openclaw.json:

```
       "cortex": {
         "enabled": true,
         "config": {
           "dbPath": "/home/abc/.openclaw/skills/cortex/yantrik_memory.db"
         }
       },
```

yantrik-memory still doesn't work for me, but it works for my agent, so I'm just gonna say "if it ain't broke, don't fix it".  If you have issues, ask your agent to troubleshoot it. lol

#### memory-wiki and obsidian

For longer-term structured storage, you can use the new memory-wiki, optionally integrated with obsidian.  You have to [edit your openclawconfig.json](https://docs.openclaw.ai/plugins/memory-wiki) (it took me like 5 minutes to find that in a sea of shitty blag arktikles.  On debian, for obsidian, I installed the .deb, which was great.  Fuck snapd, have to install a whole ass service just to install a package you could install with: Installed obsidian with dpkg atfer downloading.

OK, so if you don't know, memory-wiki stores things in obsidian-compatible wiki files and allows for more structured long-term storage.  Less "what am I working on" and more "what are the details of project slumberparty".

### Google Workspace AKA gogcli

You will have to download and install gogcli, you will have to enable all the APIs, you will have to go through the authentication gauntlet.  It will not be easy, but it is possible.  [Let github be your guide](https://github.com/steipete/gogcli).  Let setting GOG_ACCOUNT="account@google.com" GOG_KEYRING_BACKEND="file" and GOG_KEYRING_PASSWORD="thepasswordyouused" using ```export GOG_VAR="value"``` as your commands (in .bashrc, if you don't know where to put them afterwards, please do and then ```source .bashrc```.  Eventually I was able to, after "gogcli cannot store locked object" "something went wrong" and other misc errors, I finally made it.  gog calendar calendars.  I  wish I had a better walk-through for you, because it was a pain, but I don't and I don't want to repeat it, lol.

After watching my bot function, there was no way in hell I was going to let him access my primary inbox, but I did give him access to an old account.  At first he wouldn't try to access it, because he insisted it was impossible and violated various security standards and I was like "my man, I have done all that and you are set to use gog" and he was getting "calendar options: token source: get token for anchoretconjob@gmail.com: read token: Cannot get secret of a locked object" and so was I, due to the "secret service" being locked, which is why you need to set those variables above.  I had only the password set and it wasn't enough.

## What in the actual fuck?

Really?  Yes, really.

--### Is there no way to add Google AI Studio models?--

--Theoretically, this is easy.  You just put in your API key and then choose one of the models from the....there's no list of models?  No, there's no list of models that I could find, anywhere.--

[https://ai.google.dev/gemini-api/docs/model](Here is the list of models for google), you need to click into them to see the actual name].  There is, however, no list of what models are free or what the limitations are as far as number of requests or tokens.  I'm not sure how you're supposed to plan, but I guess their answer is "pay".  Once you sign up and waste more of your life, they will tell you what the current rate limit is.  Mine was 5 requests per minute and 20 per day.  How generous, considering that gemini is completely free without the API.  Someone needs to make an HTTP bridge so you can use the web interface and save like $1000/mo.  I hit my tokens per second limit after 2 requests.  Thanks, googlies.

for Gemini text/chat models, use Google’s model string with the OpenClaw provider prefix, e.g.:
google/gemini-2.5-flash
google/gemini-2.5-pro
google/gemini-3.1-pro-preview (if you really want preview -- it was not free for me.

for generation/media models, use the specialized model IDs with the google/ prefix where OpenClaw expects provider/model refs:
google/gemini-3.1-flash-image-preview
google/gemini-3-pro-image-preview
google/veo-3.1-fast-generate-preview
google/lyria-3-clip-preview
google/lyria-3-pro-preview

### Why aren't my image/song/video models showing up in models /list?

They "just don't".  Why they're not considered models, no idea

### How do I act as the agent for testing?

You can't.  You can't "send things as if you were the agent".  As far as I've found so far, there's no way to see what the agent is actually sending or receiving, so you have to just trust it's doing what it says it is and getting what it says it's getting back.  I personally think this is insane from a root cause analysis standpoint in the troubleshooting process, because if you can't find out what it's sending, how do you test it?  If there's no way to send an exec command as if from the agent, to the openclaw, and capture the response, how do you know if the commands are working properly?

### How do I leave a comment on clawhub?

--You just use their internal comment syste-- doesn't work because of a CONVEX error


## Commands

There are many commands, but these are the ones I either use a lot or love.

openclaw models
python3 -m json.tool ~/.openclaw/openclaw.json >/dev/null && echo OK || echo BROKEN
openclaw models list --plain
openclaw logs --follow
cp openclaw.json openclaw.json.bak-$(date +%F-%H%M%S)
python3 -m json.tool ~/.openclaw/openclaw.json >/dev/null && echo "OK" || echo "BAD JSON"
openclaw memory search "cumquat"

# llama.cpp and openclaw

## 1. What the settings mean

These are the main `llama.cpp` knobs you’ll actually feel.

### `-m /path/to/model.gguf`

Which brain to load.

### `-c 4096`

**Context window**.
How much text it can keep in working memory at once.

* bigger = remembers more
* bigger = more RAM and usually slower

For your machine, `4096` is a good default.

### `-t 4`

**Generation threads**.
How many CPU threads it uses while producing tokens.

* too low = leaves speed on the table
* too high = can get worse from overhead/hyperthreading weirdness

On your 4-core/8-thread box, `4` is a sane starting point.

### `-tb 8`

**Batch/prompt threads**.
This affects the “reading the prompt” side more than the “typing the answer” side.

That’s why you saw separate numbers like:

* prompt t/s
* generation t/s

So:

* `-t` mostly affects output speed
* `-tb` mostly affects input/prompt processing speed

### `-ngl 0`

**GPU layers to offload.**
For you, this means CPU-only.

* `0` = don’t bother with the GPU
* useful because your Quadro is currently not worth wrestling into service

### `--temp 0.95`

**Temperature = boldness / randomness.**

* lower (`0.4–0.7`) = safer, stiffer, more predictable
* medium (`0.8–1.0`) = natural, balanced
* higher (`1.1+`) = more creative, more weird, more likely to go off the rails

For “spicy but coherent,” `0.9–1.0` is good.

### `--top-k 50`

Only consider the **top 50 next-token candidates**.

* lower = narrower, safer
* higher = more options, more unpredictability

### `--top-p 0.95`

Only consider tokens until their combined probability mass reaches 95%.

* lower = tighter, safer
* higher = looser, more expressive

### `--min-p 0.05`

Throw away candidates that are too weak compared to the best one.

This is a **garbage filter**.

* higher = cleaner, less weird
* lower = freer, more chaotic

### `--repeat-penalty 1.08`

Punish repetition a bit.

* `1.00` = no punishment
* `1.05–1.10` = gentle anti-looping
* too high = can make writing weirdly avoidant

## Good presets

### Balanced

```bash
./build/bin/llama-cli \
  -m /path/to/model.gguf \
  -c 4096 -ngl 0 \
  --temp 0.85 \
  --top-k 40 \
  --top-p 0.95 \
  --min-p 0.05 \
  --repeat-penalty 1.08 \
  -p "Your prompt here"
```

### More creative / spicy

```bash
./build/bin/llama-cli \
  -m /path/to/model.gguf \
  -c 4096 -ngl 0 \
  --temp 0.98 \
  --top-k 50 \
  --top-p 0.97 \
  --min-p 0.04 \
  --repeat-penalty 1.06 \
  -p "Your prompt here"
```

### More stable / less token soup

```bash
./build/bin/llama-cli \
  -m /path/to/model.gguf \
  -c 4096 -ngl 0 \
  --temp 0.75 \
  --top-k 40 \
  --top-p 0.90 \
  --min-p 0.08 \
  --repeat-penalty 1.10 \
  -p "Your prompt here"
```

---

## 2. How to run it with OpenClaw

The clean path is:

### Step A: run `llama-server`

`llama.cpp`’s server exposes an **OpenAI-compatible** API, including `/v1/chat/completions`. That’s the bridge OpenClaw can use. ([GitHub][1])

Example:

```bash
./build/bin/llama-server \
  -m /models/your-model.gguf \
  --host 0.0.0.0 \
  --port 8080 \
  -c 4096 \
  -t 4 \
  -tb 8
```

That gives you:

* web UI at `http://SERVER:8080`
* chat completions at `http://SERVER:8080/v1/chat/completions` ([GitHub][2])

If you’re using Tailscale, the URL OpenClaw should hit is something like:

```text
http://100.x.y.z:8080/v1
```

### Step B: point OpenClaw at it

OpenClaw has current support for **OpenAI-compatible providers with custom base URLs**, though there have been bugs around `baseUrl` propagation in some recent versions. A config pattern shared in OpenClaw issues says to use:

* `api: "openai-completions"`
* a custom `baseUrl`
* and a manually defined model entry for the local server ([GitHub][3])

So the config shape should be roughly:

```json
{
  "models": {
    "providers": {
      "llamacpp": {
        "api": "openai-completions",
        "baseUrl": "http://100.x.y.z:8080/v1",
        "apiKey": "dummy",
        "models": [
          {
            "id": "local-writer",
            "name": "local-writer"
          }
        ]
      }
    }
  }
}
```

Then set your agent/default model to `local-writer`.

### Why `openai-completions` and not something else?

Because OpenClaw issue docs specifically note that for standard OpenAI-compatible proxies like **llama.cpp**, you want `api: "openai-completions"`. ([GitHub][3])

### Step C: restart OpenClaw

After editing config, restart it so it reloads the provider.

# AI Settings Guide for llama.cpp

This is a guide for llama.cpp settings

| Setting | What it controls | Lower values tend to do | Higher values tend to do | Good starting range | Notes |
| --- | --- | --- | --- | --- | --- |
| `-m /path/to/model.gguf` | Which model to load | Smaller/leaner model if you pick one | Larger/smarter model if you pick one | n/a | Bigger model usually means better quality but slower speed and more RAM use. |
| `-c` | Context window, how much text it can keep in mind | Less memory, faster, forgets earlier text sooner | More memory, slower, remembers more | `2048–4096` | On your box, `4096` is a solid default. |
| `-t` | Generation threads | May leave speed on the table | Can help, but too high can hurt from overhead | `4–8` | This mostly affects **generation** speed. On your machine, start with `4`. |
| `-tb` | Prompt/batch threads | Slower prompt ingestion | Faster prompt ingestion, until overhead bites | `4–8` | This mostly affects **prompt/read** speed, not final token generation. |
| `-ngl` | GPU layers to offload | CPU-only if `0` | More GPU use if supported | `0` on your box | Your current setup should use `0` unless you revisit GPU stuff later. |
| `--temp` | Boldness / randomness | More stable, literal, predictable | More creative, surprising, risky | `0.75–1.0` | Best first knob for “spicy level.” |
| `--top-k` | How many candidate next tokens are considered | Narrower, safer, more disciplined | Broader, more varied, more chaotic | `40–60` | Keep moderate. Very high values can get sloppy. |
| `--top-p` | How deep into less-likely options it can go | Tighter, safer, more mainstream | Looser, more expressive, more weird | `0.90–0.97` | Often paired with `temp`. |
| `--min-p` | Garbage filter relative to the best token | More freedom, more weirdness | Cleaner, stricter, less nonsense | `0.04–0.08` | Great anti-token-soup knob. |
| `--repeat-penalty` | How much it avoids repeating itself | More loops/repetition | Less repetition, but can get stiff if too high | `1.05–1.10` | Gentle is best. |
| `-p "..."` | Inline prompt text | Short prompt = quicker, less guidance | Longer prompt = more guidance, slower | n/a | Use `-f prompt.txt` for repeatable testing. |
| `-f prompt.txt` | Prompt from file | n/a | n/a | n/a | Best for comparing models fairly. |
| `--host 0.0.0.0` | Server bind address | Localhost only if omitted/127.0.0.1 | Reachable from Tailscale/LAN | `0.0.0.0` | Needed for remote OpenClaw access. |
| `--port 8080` | Server port | Different port | Different port | `8080` | Pick any free port. |
| `-cnv` | Conversation/chat mode in `llama-cli` | Plain completion if omitted | Chat-style interaction | on/off | Good for interactive testing. |

## Quick presets

| Style | Suggested settings | Effect |
| --- | --- | --- |
| Stable / clean | `--temp 0.75 --top-k 40 --top-p 0.90 --min-p 0.08 --repeat-penalty 1.10` | More reliable, less weird, less poetic |
| Balanced | `--temp 0.85 --top-k 40 --top-p 0.95 --min-p 0.05 --repeat-penalty 1.08` | Good default for normal writing/chat |
| Spicy / creative | `--temp 0.95 --top-k 50 --top-p 0.95 --min-p 0.05 --repeat-penalty 1.06` | Richer, freer, more expressive |
| Feral / risky | `--temp 1.05 --top-k 60 --top-p 0.97 --min-p 0.03 --repeat-penalty 1.04` | More vivid, more unstable, more token soup risk |

## One-line mental model

| Setting | Simple translation |
| --- | --- |
| `--temp` | how bold |
| `--top-k` | how many options it gets |
| `--top-p` | how deep into unlikely options it digs |
| `--min-p` | how much nonsense gets filtered out |
| `--repeat-penalty` | how hard you slap it for repeating |
| `-c` | how much it remembers |
| `-t` | how many CPU workers write |
| `-tb` | how many CPU workers read |

If you want, I can turn this into a copy-paste `README.md` block with example `llama-cli` and `llama-server` commands underneath.