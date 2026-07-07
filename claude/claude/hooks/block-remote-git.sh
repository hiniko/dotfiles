#!/usr/bin/env bash
# PreToolUse hook: block git push / PR creation / remote-write ops
# unless the user's MOST RECENT message contains the explicit phrase "GO PUSH".
#
# Rationale: local commits with Claude are fine; pushing and opening PRs are
# irreversible, outward-facing acts the user must explicitly authorize each time.
#
# Wired in settings.json under hooks.PreToolUse (matcher: "Bash").
# Hook protocol: receives JSON on stdin, exits 0 to allow,
# exits 2 to BLOCK and feed stderr back to Claude.

set -euo pipefail

PHRASE="GO PUSH"

input="$(cat)"

# Only inspect Bash tool calls.
tool="$(printf '%s' "$input" | jq -r '.tool_name // empty')"
[ "$tool" = "Bash" ] || exit 0

cmd="$(printf '%s' "$input" | jq -r '.tool_input.command // empty')"
[ -n "$cmd" ] || exit 0

# --- Does the command attempt a remote-write / PR op? ---------------------
# Match on whole-word boundaries to avoid false hits (e.g. "git pushd" n/a,
# but also avoid matching "gh pr view"). We block:
#   git push            (any form, incl. -f, --set-upstream, etc.)
#   git remote add/set-url/remove  (rewiring remotes)
#   gh pr create | gh pr merge | gh pr ready
#   gh release create
#   git push via aliases like "git p" are NOT covered (intentional).
is_blocked=0
case "$cmd" in
  *"git push"*)                       is_blocked=1 ;;
  *"git remote add"*)                 is_blocked=1 ;;
  *"git remote set-url"*)             is_blocked=1 ;;
  *"git remote remove"*)              is_blocked=1 ;;
  *"git remote rm"*)                  is_blocked=1 ;;
  *"gh pr create"*)                   is_blocked=1 ;;
  *"gh pr merge"*)                    is_blocked=1 ;;
  *"gh pr ready"*)                    is_blocked=1 ;;
  *"gh release create"*)              is_blocked=1 ;;
esac

[ "$is_blocked" -eq 1 ] || exit 0

# --- Read the user's most recent message from the transcript -------------
# Transcript is JSONL; each line a record. We want the last user text.
transcript="$(printf '%s' "$input" | jq -r '.transcript_path // empty')"
last_user_msg=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  # Grab text from the final record whose .type == "user".
  last_user_msg="$(jq -rs '
    [ .[]
      | select(.type == "user")
      | (.message.content)
      | if type == "string" then .
        elif type == "array" then ( [ .[] | select(.type=="text") | .text ] | join("\n") )
        else "" end
    ] | last // ""
  ' "$transcript" 2>/dev/null || echo "")"
fi

# --- Authorize only if the phrase is present in that last message ---------
if printf '%s' "$last_user_msg" | grep -qF "$PHRASE"; then
  exit 0
fi

# --- Block ---------------------------------------------------------------
cat >&2 <<EOF
BLOCKED by block-remote-git hook.

Command: $cmd

This is a remote-write / PR operation. Sherman's workflow requires explicit
authorization: he reviews every line and commits/pushes himself.

To proceed, the user must include the exact phrase "$PHRASE" in their next
message. Do NOT run this command. Do NOT suggest workarounds. Stop and tell
the user the push was blocked and that they can authorize it with "$PHRASE".
EOF
exit 2
