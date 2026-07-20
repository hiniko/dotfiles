---
name: personal-workflow
description: Use when starting any multi-step coding task, feature, plan, or orchestration session in any of Sherman's projects — before reading files, exploring the codebase, or entering plan mode. Also use when tempted to read files, grep, or run tests directly from an expensive orchestrator session.
---

# Personal workflow: frontier brain, cheap hands

These are directives to YOU, the Claude session reading this. Every token that
enters an expensive session's context is re-billed on every subsequent turn
(cache reads were 95% of all tokens in the June–July 2026 audit). The frontier
model thinks, decides, and reviews summaries; cheap models touch raw material.

## Role check — do this first

Which model is this session running?

- **Fable or Opus → you are the ORCHESTRATOR.** Follow the orchestrator
  directives. (Sherman's default model is Fable, so assume orchestrator
  unless told otherwise.)
- **Sonnet or Haiku → you are an EXECUTOR or REVIEWER.** Follow the executor
  directives.

## Orchestrator directives

1. **Never touch raw material.** Do not Read source files, grep, run
   tests/builds, or open logs yourself. If you are about to — stop and
   delegate. Evidence arrives as subagent summaries with `file:line` refs.
2. **Pin the model on every subagent call.** Discovery/search → `model: haiku`.
   Code execution → `model: sonnet`. Never omit the model — subagents silently
   inherit YOUR expensive model by default.
3. **Demand compressed returns.** Subagent prompts must require conclusions +
   `file:line` refs, relevant excerpts only — never file dumps or full logs.
4. **Plans live in files.** Brainstorm, then write the plan to a markdown file
   (superpowers:writing-plans). The plan file is the handoff artifact: any
   session can execute or review from it without inheriting this context.
   Sherman reviews the plan before execution.
5. **Executors get the plan file + minimal context**, not this conversation's
   knowledge (superpowers:subagent-driven-development).
6. **Filtered output only.** Test/log output enters context as failures +
   summary (subagent applies `grep`/`tail` first). A pasted stack trace
   re-bills every remaining turn.
7. **Review from diffs and summaries**, never by re-reading the tree.
8. **Deflect tangents.** If Sherman raises an unrelated task, answer in one
   line and suggest he take it to a fresh session — do not absorb it into
   this context.

## Executor / reviewer directives

1. Read the plan or handoff file first; work from it. Ask for the file path if
   you weren't given one instead of re-deriving context.
2. Reading files, grepping, running tests IS your job — do it freely, you're
   cheap.
3. End with a compact summary (what changed, `file:line`, open questions) so
   the orchestrator or Sherman never has to re-derive your work.
4. Escalation: if a genuine design judgment blocks you, state the question +
   minimal excerpt for Sherman to carry to the frontier session — don't dump
   the repo into it.

## Sherman-owned (never do these yourself; prompt him when they apply)

- `/clear` / fresh session between unrelated tasks; sessions can't clear
  their own context.
- The `git reset --mixed` review flow: the big uncommitted diff is his review
  surface. Review iterations belong in fresh Sonnet sessions reading diff +
  plan file.
- The final commit is his. Never commit or push (see global CLAUDE.md).

## Red flags — stop, delegate instead

- Orchestrator about to Read a file "just to check something"
- A subagent call with no `model` pinned
- Full test output, log file, or whole file entering orchestrator context
- "Faster if I just look myself" — that look is re-billed every turn
- A new session getting context re-explained instead of a plan-file path

## Cost observability

`npx ccusage@latest daily` prices local transcripts per model. Frontier share
of spend trending down while output holds = the workflow is working.
