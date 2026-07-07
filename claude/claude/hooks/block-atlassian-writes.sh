#!/usr/bin/env bash
# PreToolUse hook: block ALL write/mutation operations against Atlassian
# (Jira / Confluence) via the Atlassian MCP server.
#
# Rationale: Sherman owns and publishes all Atlassian output regardless of who
# or what generated it. Atlassian access is strictly READ-ONLY for Claude.
# Reads (search, get, fetch, list, lookup) are allowed; any create/edit/
# transition/comment/worklog/link/update is blocked.
#
# Wired in settings.json under hooks.PreToolUse (matcher: "mcp__.*atlassian.*").
# Hook protocol: receives JSON on stdin, exits 0 to allow,
# exits 2 to BLOCK and feed stderr back to Claude.

set -euo pipefail

input="$(cat)"

tool="$(printf '%s' "$input" | jq -r '.tool_name // empty')"
[ -n "$tool" ] || exit 0

# Only inspect Atlassian MCP tool calls. Anything else: not our concern.
case "$tool" in
  *atlassian*) ;;
  *) exit 0 ;;
esac

# --- Allowlist: read-only Atlassian tools --------------------------------
# Match the bare verb after the final "__" so server-prefix changes don't
# break this. Reads are allowed; everything else is blocked (deny-by-default).
verb="${tool##*__}"

case "$verb" in
  # OAuth handshake (auth only, not a Jira/Confluence mutation)
  authenticate|complete_authentication \
  |search|fetch|atlassianUserInfo \
  |getAccessibleAtlassianResources|lookupJiraAccountId \
  |getVisibleJiraProjects \
  |getJiraIssue|searchJiraIssuesUsingJql \
  |getJiraIssueRemoteIssueLinks|getTransitionsForJiraIssue \
  |getIssueLinkTypes|getJiraIssueTypeMetaWithFields \
  |getJiraProjectIssueTypesMetadata \
  |getConfluenceSpaces|getConfluencePage|getPagesInConfluenceSpace \
  |getConfluencePageDescendants|getConfluencePageFooterComments \
  |getConfluencePageInlineComments|getConfluenceCommentChildren \
  |searchConfluenceUsingCql)
    exit 0
    ;;
esac

# --- Anything not explicitly allowed is a write: BLOCK -------------------
cat >&2 <<EOF
BLOCKED by block-atlassian-writes hook.

Tool: $tool

Atlassian (Jira / Confluence) access is strictly READ-ONLY. This tool mutates
Atlassian state (create / edit / transition / comment / worklog / link /
update), which Sherman must do himself — he reviews and owns all output.

Do NOT run this. Do NOT seek workarounds. Stop and tell Sherman the write was
blocked. If he genuinely wants it done, he will say so explicitly; even then,
he prefers to push Atlassian changes himself.
EOF
exit 2
