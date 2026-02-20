---
description: Validate adherence and generate summary artifact
---
Load and use the `summarize` skill.

Input (requirements/plan references or task slug):
$ARGUMENTS

If a task slug is provided, resolve inputs as:
- `workflow/requirements/{task-name}.md`
- `workflow/plans/{task-name}.md`

Follow the skill workflow and output contract exactly.
