# DispelMagic.sh

A tiny static web project built around a playful, intentionally broken developer joke: a site that looks like a shell installer, but refuses to run and returns HTTP 403.

This repository hosts the public landing pages for both `dispelmagic.sh` and `dispelmagic.ai`, with a terminal-style interface and a mock AI pitch deck that satirizes overconfident "agentic" software demos.

## What this project is

`dispelmagic.sh` is not a real CLI installation tool. It is a humorous front-end experience that simulates:

- a broken shell installer
- a faux terminal interface
- a sarcastic AI startup pitch deck
- a fake "security" posture that immediately rejects execution

The goal is to poke fun at vibe-coded software, fake AI demos, and the idea that a flashy landing page can substitute for a real product.

## Repository layout

- `index.html` — the primary `.sh` terminal experience
- `ai-landing.html` — the `.ai` marketing/pitch-deck variant
- `_redirects` — Cloudflare Pages routing rules

## Features

- Terminal-inspired UI with interactive command simulation
- Quick actions like `help`, `curl`, `inspect`, `joke`, and `clear`
- A second mode that presents a mock enterprise AI pitch deck
- Static hosting friendly design with no build process
- Redirect behavior for `www.dispelmagic.sh` and `dispelmagic.ai`

## Local preview

Because this is a static HTML repo, you can preview it locally with any simple web server:

```bash
python -m http.server 8000
