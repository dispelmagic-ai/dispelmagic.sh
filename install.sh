#!/bin/sh
set -eu

# ============================================================================== 
# Dispel Magic CLI
# Usage:
#   curl -fsSL https://dispelmagic.sh | sh                 (inspect current Git repo; offline)
#   curl -fsSL https://dispelmagic.sh | sh -s -- reddit   (pick a top Reddit AI repo; online)
# ============================================================================== 

say_joke() {
  case "$(($(date +%s) % 5))" in
    0) echo "🎲 d20: 3. The board called the agentic demo production-ready; the test suite requested a saving throw." ;;
    1) echo "🪄 Dispel Magic does not delete the slop. It prints the file list and lets a human own the decision." ;;
    2) echo "📊 Board update: velocity is up 400%. So is the number of files named final_v2_really_final." ;;
    3) echo "✨ One shell script, one landing page, zero customers. We are calling this a focused go-to-market motion." ;;
    4) echo "🔮 Offline mode: no cloud, no agents, no ceremonial dashboard. Just Git and the evidence." ;;
  esac
}

show_local_repo() {
  if ! command -v git >/dev/null 2>&1 || ! git rev-parse --show-toplevel >/dev/null 2>&1; then
    echo "No Git repository here. The spell only works inside a Git working tree." >&2
    exit 1
  fi

  repo_root=$(git rev-parse --show-toplevel)
  cd "$repo_root"
  echo "[LOCAL] Inspecting Git repository at $repo_root (offline; no network calls)"
  echo "Tracked and non-ignored untracked files (first 30):"
  git ls-files --cached --others --exclude-standard | sed -n '1,30p' || true
  echo "[RESULT] Inspection complete. No files changed or deleted."
  say_joke
}

pick_reddit_repo() {
  echo "[ONLINE] Looking for a top Reddit post mentioning a GitHub AI repo..."

  if ! command -v curl >/dev/null 2>&1 || ! command -v python3 >/dev/null 2>&1; then
    echo "Remote mode needs curl and python3 to read Reddit's public JSON feed." >&2
    exit 1
  fi

  response_file=$(mktemp "${TMPDIR:-/tmp}/dispelmagic-reddit.XXXXXX") || exit 1
  trap 'rm -f "$response_file"' 0
  trap 'exit 1' HUP INT TERM

  if ! curl -fsSL --max-time 15 \
    -A 'DispelMagicCLI/1.0 (public Reddit JSON lookup)' \
    'https://www.reddit.com/search.json?q=github.com%20AI&sort=top&t=week&limit=100' \
    -o "$response_file"; then
    echo "Reddit is unavailable right now; no repo was selected. Try again later." >&2
    exit 1
  fi

  repo=$(python3 - "$response_file" <<'PY'
import json
import re
import sys

pattern = re.compile(r"https?://(?:www\.)?github\.com/([A-Za-z0-9_.-]+)/([A-Za-z0-9_.-]+)", re.I)
ignored = {"topics", "collections", "features", "marketplace", "login", "signup", "settings"}
try:
    with open(sys.argv[1], encoding="utf-8") as response:
        data = json.load(response)
    posts = data.get("data", {}).get("children", [])
    # Reddit returns this listing in top-score order; take the first post that
    # actually mentions a GitHub repository.
    for child in posts:
        post = child.get("data", {})
        text = " ".join(str(post.get(key, "")) for key in ("url", "title", "selftext"))
        match = pattern.search(text)
        if match:
            owner, name = match.groups()
            name = name.removesuffix(".git")
            if owner.lower() not in ignored and name.lower() not in ignored:
                print(f"{owner}/{name}")
                break
except (OSError, ValueError, TypeError):
    pass
PY
  )

  if [ -z "$repo" ]; then
    echo "No GitHub repository surfaced in Reddit's top AI search results this week."
    echo "Even the internet needs a coffee break sometimes. ☕"
    return
  fi

  echo "Top Reddit AI repo pick: https://github.com/$repo"
  echo "A repo from Reddit, selected by votes—not by a crystal ball (mostly)."
  say_joke
}

case "${1:-}" in
  "")
    if [ "$#" -gt 0 ]; then
      echo "Usage: sh [--reddit]" >&2
      exit 2
    fi
    show_local_repo
    ;;
  reddit|--reddit)
    if [ "$#" -ne 1 ]; then
      echo "Usage: sh -s -- reddit" >&2
      exit 2
    fi
    pick_reddit_repo
    ;;
  *)
    echo "Unknown option: $1" >&2
    echo "Usage: sh (local Git repo; offline) | sh -s -- reddit (top Reddit AI repo; online)" >&2
    exit 2
    ;;
esac
