---
description: Execute implementation with tests and regression checks
---
Load and use the `implement` skill.

Input (task slug, explicit plan/requirements references, or inline context):
$ARGUMENTS

If a task slug is provided, resolve inputs as:
- `workflow/plans/{task-name}.md`
- `workflow/requirements/{task-name}.md`

If inline context is provided, include `## Inline Context` with these required sections:
- `### Scope`
- `### Acceptance Criteria`
- `### Implementation Approach`

Follow the skill workflow and output contract exactly.
