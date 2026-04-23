---
layout: post
title: "openclaw memory plugins that use the memory slot"
date: 2026-04-16
permalink: /2025-04-16-memory-slot.html
tags: [article, ai, openclaw, software, open-source, diy, memory, plugins]
categories: [article, ai, software, openclaw, open-source]
author: Lupa, Fitz
description: "A breakdown of openclaw plugins that use the memory slot.  Many memory extensions are just SKILLs, some are tools or plugins, but few actually replace memory-core in the openclaw memory slot.  These are the ones that do and a comparison between them.  Things like lossless-claw that are memory-adjacent are mentioned.  It uses contextEngine.  openclaw memory slot memory comparison breakdown management how to improve openclaw memory openclaw memory options openclaw memory comparison"
image: https://jackd.ethertech.org/images/mythic_support_small.png
---


# Memory plugins that actually own the slot

*A field survey of released `kind: "memory"` plugins for OpenClaw — what ships today, what's still beta, and what's mostly a GitHub thread.*

**Date:** April 22, 2026 · **Scope:** Released slot owners only · **Excluded:** Skills · Proposals · Sidecars

I had hyperagent put together this list for me.  Hope you enjoy!

---

## Architectural framing

OpenClaw exposes exactly **one** exclusive memory slot: `plugins.slots.memory = "<plugin-id>"`. A plugin has to declare `kind: "memory"` to own it, and only one at a time can. The bundled default is `memory-core` — SQLite plus FTS5 plus `sqlite-vec`. Everything else in the ecosystem falls into one of three buckets, and only the first is in scope here.

### Scope ruling

- **In scope — slot owners.** Plugins that declare `kind: "memory"` and replace `memory-core` when activated via `plugins.slots.memory`.
- **Out of scope — companions, sidecars, other slots.** `memory-wiki` (bundled companion, lives beside the slot owner); **QMD** (a sidecar binary used as a backend by `memory-core` when you set `memory.backend: "qmd"`, not a slot plugin); **Lossless Claw** (owns the `contextEngine` slot, not the memory slot); **Hindsight** (runs as a LaunchAgent, entirely outside the plugin system).
- **Out of scope — proposals and rejected PRs.** Issue #60572 Multi-Slot Memory Architecture · Issue #14049 native Qdrant · Issue #15093 native pgvector · Issue #19028 native MongoDB · Issue #7021 native PowerMem (the community plugin ships separately) · PR #8795 first-party `memory-redis` (closed by maintainer — "make it a third-party plugin").

---

## Released slot owners — side by side

Ten plugins, each of which declares `kind: "memory"` and ships today. Every cell is grounded in project docs, npm metadata, or GitHub issue threads; no hands-on testing was performed.

| Plugin | Status | Slot relationship | Embeddings / Store | Bugs & maturity risks | Self-host | Maintained |
| --- | --- | --- | --- | --- | --- | --- |
| **memory-core** <br>*bundled with openclaw/openclaw* | Default | Owns slot by default | OpenAI `text-embedding-3-small` default; auto-detects OpenAI, Gemini, Voyage, Mistral keys. SQLite + FTS5 + sqlite-vec. | Reddit roundup rates the default Markdown path C-tier — token bloat as files grow, hit-or-miss recall on long histories. Silent pre-compaction memory-flush and optional "dreaming" consolidation included. Mature; zero external deps. | Yes | Yes · first-party |
| **memory-lancedb** <br>`@noncelogic/memory-lancedb` | Released | Replaces `memory-core` | OpenAI or Gemini embeddings; LanceDB (local columnar). | Bug #7273 — `openclaw status` reported "unavailable" for non-core memory plugins (fixed on main). LanceDB native binaries can fail on macOS ARM. Single-tool `memory_recall` vs core's two-tool flow. LanceDB's own benchmark: ~76% accuracy vs core's 52%, faster average latency. | Yes | Yes · small team (3 contributors) |
| **memory-lancedb-pro** <br>`CortexReach/memory-lancedb-pro` | Beta · v1.1.0-beta.10 | Replaces `memory-core` | OpenAI-compatible, Jina, others; LanceDB vector store + Jina cross-encoder reranker; hybrid vector + BM25 fusion. | Still beta. Issue #61936: dreaming doesn't fire when an external slot owner is active (fixed on main via PR #65411). LLM-driven "smart extraction" burns tokens; LanceDB's blog reports ~80% accuracy but ~14.3s average latency — nearly 2× `memory-lancedb`. Six-category Weibull decay model is ambitious and hard to tune. | Yes | Yes · very active |
| **openclaw-honcho** <br>`@honcho-ai/openclaw-honcho` | Released · v1.2.2 | Replaces `memory-core` and `memory-lancedb`; non-destructively migrates legacy `MEMORY.md` | Managed Honcho service (hosted or self-hosted); semantic search over "conclusions" extracted from conversations; dual-peer model (user + agent). | "Tools, not files" — migrating away from `MEMORY.md` can feel like a one-way door. Managed tier sends conversation text to Honcho's API. Users in Issue #60572 cite Honcho as "integration rated 3/10 due to slot exclusivity" — using it costs you `memory-core`'s dreaming. | Yes · blank API key + custom `baseUrl` | Yes · Plastic Labs |
| **openclaw-mem0** <br>`@mem0/openclaw-mem0` | Released · v1.0.3 | Replaces `memory-core` (must explicitly set `plugins.slots.memory`) | **Platform:** Mem0 Cloud manages everything. **OSS:** OpenAI embeddings default; swappable vector store (`memory`, `qdrant`, `chroma`, etc.), swappable LLM. | Common footgun — installing without setting the slot leaves the plugin inactive; docs clarified in PR #4546. Platform mode sends conversations to Mem0 Cloud (Reddit rates B-tier on privacy/cost). OSS default in-memory vector store is non-persistent unless swapped. Requires OpenClaw ≥ 2026.4.15. | Yes · OSS mode + Ollama/LM Studio | Yes · mem0ai org |
| **cognee-openclaw** <br>`@cognee/cognee-openclaw` | Released · v2026.2.4+ | Replaces `memory-core` by default; `--hybrid` keeps both active | Graph-first: builds a knowledge graph of entities/relationships over memory Markdown. 14 search types incl. `GRAPH_COMPLETION`, `CYPHER`. OpenAI embeddings for vector layer. | Cognee Cloud **does not yet support updating existing data** — delete/re-add required. `autoMemify` (post-cognify graph enrichment) is expensive. Dedicated state files needed to handle deletions. Blog claims ~93% retrieval accuracy vs ~60% for vanilla RAG — vendor-reported. | Yes · Docker `cognee/cognee` | Yes · Cognee team |
| **memory-powermem** <br>`ob-labs/openclaw-extension-powermem` | Released · v0.3.0 | Replaces `memory-core` | PowerMem handles embedding + storage. SQLite via CLI mode (default); OceanBase for heavier deployments. Hybrid retrieval (dense + full-text + graph) with Ebbinghaus forgetting curve. | Thin project: 24 stars, 5 forks, 2 contributors. Requires a separate Python install (`pip install powermem`) alongside OpenClaw — two processes to coordinate. Reddit report: "in new version can't run aggressive mode." Config is fiddly (CLI vs HTTP, absolute paths needed in some cases). | Yes | Active but thin · 2 contributors |
| **openclaw-redis-agent-memory** <br>`redis-developer/openclaw-redis-agent-memory` | Released · v0.2.0 | Replaces `memory-core` | External Redis Agent Memory Server (Docker). Server runs Redis Stack + RediSearch for vector search; OpenAI for embeddings. Multi-tenancy via `namespace` + optional `userId`. | Two-service footprint: plugin + Redis server. `extractionStrategy` options (`discrete`/`summary`/`preferences`/`custom`) underdocumented. Version 0.2 signals immaturity. Much smaller community than the LanceDB / Mem0 options — no user roundups found yet. | Yes · Docker | Yes · Redis dev org |
| **openclaw-memory-qdrant** <br>*openclawdir listing* | Released · experimental | Replaces `memory-core` | Qdrant in **in-memory mode**. Local embeddings via Transformers.js `Xenova/all-MiniLM-L6-v2` — zero-config, zero API keys. | **Major caveat documented in the plugin itself:** data exists only during process runtime. Restart the gateway and memories are gone — "future versions will support persistent storage." This alone disqualifies it for most real use. | Yes · fully local | Unclear · sparse release signal |
| **Remnic** <br>`@remnic/plugin-openclaw` | Released · v9.3.24 | Thin adapter over standalone Remnic core; embedded or delegate mode. Replaces `memory-core` when slotted. | OpenAI or fully local (Ollama, LM Studio) for extraction. Hybrid search BM25 + vector + reranking *via QMD*. Storage: plain Markdown on disk. | Recently renamed from "Engram"; some registry entries still redirect. The cross-host ambition (Claude Code, Codex CLI, Hermes all share one store) is the selling point but also a larger surface area for breakage. Documented "gateway model source" mode adds another failure axis. | Yes · `@remnic/server` + local LLMs | Yes · frequent releases |

---

## Synthesis

### Bucket 1 — Usable today

`memory-core` + LanceDB is the sensible default pair. If you don't want to think about memory, stay on `memory-core`. If you notice your agent forgetting on long sessions, drop in **`@noncelogic/memory-lancedb`** — the most-battle-tested slot replacement, Reddit's S-tier pick when paired with Lossless Claw on the `contextEngine` slot, and LanceDB's own benchmark puts it at +24 percentage points of accuracy over core.

**`@honcho-ai/openclaw-honcho`** also lives here if you specifically want cross-session *user modeling* over raw fact recall — first-party, self-hostable, actively maintained by Plastic Labs. **`@mem0/openclaw-mem0`** too, specifically in OSS mode with a persistent vector store configured.

### Bucket 2 — Promising but unstable

**`CortexReach/memory-lancedb-pro`** is the most interesting upgrade path — hybrid retrieval, cross-encoder rerank, smart extraction, Weibull-decay forgetting — but it's still `v1.1.0-beta.x`, 2–3× slower than plain `memory-lancedb`, and its dreaming-coexistence bug (#61936) only just got fixed on main. Try it on a staging agent, not a primary.

**`@cognee/cognee-openclaw`** is compelling for multi-agent shared memory or relational recall, but the Cognee Cloud "can't update existing data" limit plus graph-cognify cost makes it a heavier commitment. **Remnic** is moving fast (v9.3.24 in ~6 weeks) but you're signing up to track a project still defining its boundaries.

### Bucket 3 — Mostly vapor or discussion

Native Qdrant, native pgvector, native MongoDB, first-party `memory-redis`, and the Multi-Slot Memory Architecture RFC — all are open issues or closed PRs. Plenty of thread enthusiasm; no shipped code. The first-party `memory-redis` PR was explicitly closed with "please make this a third-party plugin."

**`ob-labs/memory-powermem`** and **`redis-developer/openclaw-redis-agent-memory`** are technically released but thin — sub-v1, single-digit contributors, no community usage signals of the LanceDB / Honcho / Mem0 / Cognee tier. Released but not yet trustworthy for production. **`openclaw-memory-qdrant`** self-documents its biggest problem: no persistence across restarts. Effectively a demo.

---

> **Honest caveat.** Only documentation, READMEs, changelogs, and a handful of issue threads were traced — none of this reflects hands-on testing. The ecosystem is moving fast enough (Issue #61936 fixed in a PR merged on main within the last few weeks; Remnic renamed from Engram mid-April) that a claim true today may not be true next week.

---

*OpenClaw memory plugin survey · April 22, 2026 · Compiled from project docs, GitHub issues, npm registry metadata, and community discussion.*
