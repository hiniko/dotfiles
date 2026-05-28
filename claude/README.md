# claude — Claude Code config

Unlike the other dotfile packages (which symlink a whole file/dir into `$HOME`),
this one symlinks **per file** into `~/.claude`. That dir is mostly machine-only
state (sessions, history, plugin cache, creds) which must NOT be tracked, and we
want each machine to be able to add **local-only** hooks/skills beside the
tracked ones.

## Install (per machine)

```sh
./link.sh
```

Then restart Claude Code so hooks load.

`link.sh` walks `.claude/`, recreates the dir tree as real dirs under
`~/.claude`, and symlinks each file. Conflicting real files are backed up as
`<name>.bk` (gitignored). Re-running is safe and idempotent; untracked local
files are left alone.

## What's tracked

```
.claude/
  settings.json                 # full config: permissions, model, plugins, hooks
  hooks/
    block-remote-git.sh         # HARD block on git push / gh pr create / remote
    							  # writes unless the latest user message contains
    							  # the phrase "GO PUSH"
  skills/                       # global skills (add more here over time)
```

## Adding a global hook/skill

Drop the file under `.claude/hooks/` or `.claude/skills/` here, commit, run
`./link.sh` on each machine. For hooks, also register them in
`settings.json` under `hooks.*`.

## Adding a machine-LOCAL hook/skill

Put it directly in `~/.claude/hooks/` (or `skills/`). It sits beside the
symlinks, untracked, invisible to this repo.

## The git push guard

`block-remote-git.sh` is a PreToolUse hook. It exits 2 (block) on `git push`,
`gh pr create|merge|ready`, `gh release create`, and `git remote` rewrites —
UNLESS Sherman's most recent message contains `GO PUSH`. Local commits and
everything else pass through. Rationale: every line is reviewed and committed
by hand; pushes/PRs are irreversible and must be authorized explicitly each
time.

Dependency: `jq` (install on Linux machines).
```
