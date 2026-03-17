---
description: Validate adherence and generate summary artifact
---
Load and use the `summarize` skill.

Input (task slug, external reference URL, inline context, branch/range, or empty for git-only):
$ARGUMENTS

If a task slug is provided, resolve inputs as:
- `workflow/requirements/{task-name}.md`
- `workflow/plans/{task-name}.md`

Supported modes:
- Git-only (no arguments or branch/range)
- External reference (URL or pasted requirements)
- Local files (task slug)

Follow the skill workflow and output contract exactly.
