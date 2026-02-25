#!/usr/bin/env bash
#
# Claude Code status line script.
#
# Shows: [Model] ▓▓░░░░░░░░ 20% | $1.23 | ⬆ 1.2.3
#
# The update indicator only appears when a newer version of Claude Code
# is available. The version check hits the GitHub Releases API via
# curl (no auth needed — public repo, ~40ms CPU). It runs in the
# background (at most once per hour) so it never blocks the status
# line render.

set -euo pipefail

CACHE_FILE="${HOME}/.claude/claude-update-check.json"
CACHE_TTL=3600 # 1 hour

# --- Read stdin JSON from Claude Code ---
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
current_version=$(echo "$input" | jq -r '.version // ""')

# --- Context bar ---
bar_width=10
filled=$((pct * bar_width / 100))
empty=$((bar_width - filled))
bar=$(printf "%${filled}s" | tr ' ' '▓')$(printf "%${empty}s" | tr ' ' '░')

# --- Format cost ---
cost_fmt=$(printf "\$%.2f" "$cost")

# --- Base line ---
line="[${model}] ${bar} ${pct}% | ${cost_fmt}"

# --- Update check (non-blocking) ---
update_text=""

if [[ -n "$current_version" ]]; then
  refresh=false

  if [[ -f "$CACHE_FILE" ]]; then
    checked_at=$(jq -r '.checked_at // 0' "$CACHE_FILE" 2>/dev/null || echo 0)
    now=$(date +%s)
    age=$((now - checked_at))
    if [[ $age -gt $CACHE_TTL ]]; then
      refresh=true
    fi
  else
    refresh=true
  fi

  # Spawn background refresh if cache is stale. The result will appear
  # on the next status line render (after the next assistant message).
  if $refresh; then
    (
      tag=$(curl -sf --max-time 5 \
        "https://api.github.com/repos/anthropics/claude-code/releases/latest" \
        | jq -r '.tag_name // empty')
      latest="${tag#v}" # strip leading "v"
      if [[ -n "$latest" ]]; then
        printf '{"latest_version":"%s","checked_at":%d}\n' \
          "$latest" "$(date +%s)" > "${CACHE_FILE}.tmp"
        mv "${CACHE_FILE}.tmp" "$CACHE_FILE"
      fi
    ) &>/dev/null &
    disown
  fi

  # Read cached latest version and compare.
  if [[ -f "$CACHE_FILE" ]]; then
    latest=$(jq -r '.latest_version // ""' "$CACHE_FILE" 2>/dev/null || true)
    if [[ -n "$latest" && "$latest" != "$current_version" ]]; then
      # sort -V puts the smaller version first. If current_version sorts
      # first (i.e. is older), an update is available.
      older=$(printf '%s\n%s\n' "$current_version" "$latest" | sort -V | head -n1)
      if [[ "$older" == "$current_version" ]]; then
        update_text=" | \033[32m⬆ ${latest}\033[0m"
      fi
    fi
  fi
fi

echo -e "${line}${update_text}"
