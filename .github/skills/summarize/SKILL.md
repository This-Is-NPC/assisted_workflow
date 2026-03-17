---
name: summarize
description: Review delivery adherence and generate summary artifacts. Works independently from git history, with an external reference (URL/inline requirements), or from local workflow files. Use when a user asks to summarize implementation work, compare delivery against requirements, or create `workflow/summaries/{task-name}.md`.
argument-hint: "[task slug, external reference URL, inline context, or empty for git-only]"
model-tier: medium
---

# Summarize

Run workflow delivery-review: verify requirement adherence (when available) and produce a summary document.

Input (task slug, external reference, inline context, or empty):
$ARGUMENTS

## Input Resolution

### Mode A — Git History Only

Activated when `$ARGUMENTS` is empty or contains only a branch name or commit range.

Derive everything from git log, diffs, and commit messages. No requirements comparison is performed and the **Deviations** section is omitted from the summary.

### Mode B — External Reference

Activated when `$ARGUMENTS` contains a URL (issue, task, PR) or pasted requirements text.

The agent documents the implementation AND compares it against the provided reference, producing a **Deviations** section.

### Mode C — Local Files (default)

Activated when a task slug or file paths are provided. Resolve inputs as:
- `workflow/requirements/{task-name}.md`
- `workflow/plans/{task-name}.md`

## Workflow

0. Read `CONTRIBUTING.md` for project standards, template paths, and tool configuration. Use the **Workflow Templates** section to locate the summary template path.

1. Load review inputs.
- **Mode A**: inspect current branch git log and diffs. Read the summary template from the path specified in `CONTRIBUTING.md`.
- **Mode B**: fetch or read the external reference. Inspect branch content. Read the summary template from the path specified in `CONTRIBUTING.md`.
- **Mode C**: read `workflow/requirements/{task-name}.md`, `workflow/plans/{task-name}.md`. Inspect branch content. Read the summary template from the path specified in `CONTRIBUTING.md`.

2. Perform adherence analysis (Mode B and Mode C only).
- Compare implemented behavior to requirements and Definition of Done.
- Evaluate each acceptance criterion as `met` or `not met`.
- Record explicit deviations and rationale.
- Skip this step entirely for Mode A.

3. Build summary artifact.
- For Mode C: create `workflow/summaries/{task-name}.md`.
- For Mode A/B: create summary in an appropriate location or return inline.
- Fill the summary template completely with no placeholders.
- Include:
  - before/after state
  - key changes
  - files updated
  - validation evidence (tests and regression checks)
  - **Deviations** section (Mode B and Mode C only) — filled with actual deviations or explicitly marked "None"
  - risks and follow-ups
  - references (issue, commits, branch — no local file paths)

## Output Contract

Return sections in this order:

1. Adherence matrix (`criterion -> status -> evidence`) — Mode B and Mode C only.
2. Summary artifact status:
- file path
- completion state

## Quality Checks

- Do not leave any acceptance criterion unaccounted for (Mode B/C).
- When requirements are available (Mode B/C), deviations must be explicit — either list actual deviations or state "None".
- Keep deviations explicit and reviewable.
- Keep summary content sufficient for reviewer decision-making.
- Keep evidence concrete and traceable to repository changes.
