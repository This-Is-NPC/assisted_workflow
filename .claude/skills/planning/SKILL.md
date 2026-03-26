---
name: planning
description: Build implementation plans from approved requirements in this repository workflow. Use when a user asks to create `workflow/plans/{task-name}.md` from approved requirements, including testing strategy, impact analysis, and regression-risk mitigation.
argument-hint: "[requirements doc path or task slug]"
model-tier: large
---

# Planning

Run the planning phase from the official workflow: produce an execution-ready plan file traceable to requirements.

Input (requirements doc path or task slug):
$ARGUMENTS

If a task slug is provided, resolve it to `workflow/requirements/{task-name}.md`.

## Workflow

0. Read `CONTRIBUTING.md` for project standards, template paths, and tool configuration. Use the **Workflow Templates** section to locate the plan template path.

1. Load planning inputs.
- Read `workflow/requirements/{task-name}.md` as source of truth.
- Read the plan template from the path specified in `CONTRIBUTING.md` and use it as the base structure.
- Search for `architecture.md` and `requirements.md` in the repository. If found, read them and use the documented patterns, stack, conventions, and business rules as constraints for the plan.

2. Map requirements to plan sections.
- Convert each acceptance criterion into planned work.
- Ensure coverage across architecture, tasks, and deliverables.

3. Author complete plan artifact.
- Create `workflow/plans/{task-name}.md`.
- Remove all placeholders from the template.
- Preserve the template structure where applicable and add missing required sections when the template does not explicitly include them.
- Include mandatory elements:
  - implementation phases
  - task breakdown
  - deliverables per phase
  - testing strategy (automated and/or manual)
  - impact analysis on existing features
  - regression risks and mitigation
  - dependencies and assumptions

4. Verify traceability before finalizing.
- Confirm every requirement is mapped to at least one task and one validation path.
- Confirm risks include concrete mitigation actions.

## Output Contract

Return sections in this order:

1. Plan artifact path.
2. Traceability matrix summary (`requirement -> planned task/test`).
3. Top risks and mitigation summary.

## Quality Checks

- Keep the plan actionable without extra interpretation.
- Keep test strategy explicit for new and impacted behavior.
- Keep risk analysis concrete and implementation-oriented.
- Never leave template placeholders unresolved.
- When `architecture.md` or `requirements.md` are available, ensure the plan does not contradict documented patterns, stack choices, or business rules.
