---
name: commit
description: Create commits for all pending repository changes by strictly following CONTRIBUTING.md commit rules. Use when the user asks to commit changes, organize commits by scope, avoid oversized commits, or enforce Conventional Commits messages in English.
argument-hint: "[optional context]"
model-tier: small
---

# Commit

## Overview

Create small, scoped commits from the current working tree.
Follow `CONTRIBUTING.md` exactly for commit standards and message format.

Additional context (optional):
$ARGUMENTS

## Workflow

0. Read `CONTRIBUTING.md` for project standards, template paths, and tool configuration.
1. Inspect pending changes with `git status --short` and `git diff --name-only`.
2. Group files by a single intent per commit (`feat`, `fix`, `docs`, `refactor`, `chore`, `test`, `build`, `ci`, `perf`).
3. When one file contains multiple scopes, separate changes into scope-specific commits using non-interactive staging/editing.
4. Stage only the files/hunks for one scope and commit.
5. Repeat until all pending changes are committed.

## Co-authorship

- **Never** add `Co-Authored-By` or any co-author trailer to commit messages.
- Only include co-author information when the user **explicitly** requests it in the current conversation.

## Execution Checklist

1. Confirm grouping is by scope, not by file count only.
2. Confirm commit message type matches the real change intent.
3. Confirm message is English and concise.
4. Confirm no unrelated file is staged.
5. Confirm no `Co-Authored-By` trailer is present (unless explicitly requested).
6. Confirm working tree is clean after final commit.
