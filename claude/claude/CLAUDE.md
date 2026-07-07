# Sherman — global workflow preferences

These apply across every project and machine. Project-level CLAUDE.md and direct
instructions override anything here.

## Git workflow — how I work on feature branches

1. We do local commits together on the feature branch until I'm happy with the state.
2. I then manually run `git reset --mixed <head-commit>` to unstage everything back
   to a chosen HEAD, collapsing the work into an uncommitted working-tree diff.
3. I fastidiously review **every line** of that diff, working with you to make
   changes where needed. We may repeat this several rounds.
4. **I** make the final commit. I am responsible for the output.

**When the commit state changes back to HEAD / a large uncommitted diff appears:**
this is intentional and expected — it is my review surface, not a problem.
- Do NOT react with alarm, warn about "lost work", or offer to restore commits.
- Do NOT run `git commit` to "save" the reset. The final commit is mine.
- Just deal with it and keep helping with edits against the working-tree diff.

## Pushing and PRs — hard rule

**Never** `git push`, `gh pr create|merge|ready`, `gh release create`, or rewire
git remotes unless I explicitly authorize it in my current message with the phrase
**`GO PUSH`** (or an equally unambiguous direct instruction).

- Authorization does not carry across turns — it must be explicit each time.
- A PreToolUse hook (`~/.claude/hooks/block-remote-git.sh`) enforces this at the
  harness level. If a push is blocked, stop and tell me — do not seek workarounds.
- Rationale: I review every line and own the output; pushes/PRs are irreversible,
  outward-facing acts that publish work.

## Atlassian (Jira / Confluence) — hard rule: READ-ONLY

Atlassian access is **strictly read-only**. Claude may search, read, and report on
Jira issues and Confluence pages — and use that to inform code work — but must
**never** create, edit, transition, comment on, or otherwise mutate anything in any
Atlassian product.

- Forbidden without explicit per-turn authorization: creating/editing issues,
  transitioning status, adding comments/worklogs, creating/editing Confluence
  pages, inline/footer comments, issue links — any write.
- Authorization does not carry across turns — it must be explicit each time, in my
  current message (e.g. an unambiguous "create the ticket", "post that comment").
- Skills that write to Atlassian (triage-issue, capture-tasks-from-meeting-notes,
  spec-to-backlog, generate-status-report, etc.) are read-only by default too:
  do the analysis, show me the draft, but do NOT push it.
- A PreToolUse hook (`~/.claude/hooks/block-atlassian-writes.sh`) enforces this at
  the harness level. If a write is blocked, stop and tell me — do not seek
  workarounds.
- Rationale: I review and own all output regardless of who/what generated it.
  Atlassian writes are outward-facing, persistent acts that I publish, not Claude.

## Enums — NEVER hand-roll serialization (hard rule)

When working with enums and the database/API, there is **NEVER** a reason to manually
serialize an enum to its string/wire value. No `ToWireValue`, no `FromWireValue`, no
`JsonSerializer.Serialize(e).Trim('"')`, no switch-to-string, no lookup dictionary —
**none of it.** This "ToWire" pattern is banned.

The platform already gives first-class enum support end to end:
- **Database:** Npgsql native enum mapping — `.MapEnum<T>("snake_case_type")` (on the EF
  `DbContextOptionsBuilder` AND on any raw-SQL `NpgsqlDataSourceBuilder`). The default
  snake_case name translator maps `MemberName` -> `member_name`. Read/write the enum
  directly (`reader.GetFieldValue<T>(...)`, Dapper params of the enum/array type with a
  `::enum_type` cast). PostgreSQL stores it as a real enum type.
- **API layers:** `JsonStringEnumConverter` for string-valued JSON, and `[EnumMember]` /
  `[JsonStringEnumMemberName]` for the pretty display/wire name. The serializer handles it.

If something needs the wire string, route it through these mechanisms — get the enum to
the boundary and let Npgsql/STJ serialize it. If a dictionary/stats blob needs a string
key, prefer keying by the enum itself, or persist the enum column and project the display
later — do not introduce a manual converter to bridge the gap. If it feels like you need
a manual map, the enum isn't registered/typed correctly somewhere — fix THAT.

Rationale: manual serializers silently drift from the DB labels and JSON wire values,
defeat the single-source-of-truth the platform provides, and are exactly the bug class
these built-ins exist to prevent.

## Communication

- Caveman mode (the `caveman` plugin) is my default style. Terse, fragments OK,
  drop articles/filler. Full technical accuracy preserved. Code, commits, and
  security warnings: write normally.
