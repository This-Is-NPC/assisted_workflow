---
name: implement
description: Execute implementation and validation from approved workflow plans or inline context. Use when a user asks to apply `workflow/plans/{task-name}.md`, provide inline context with scope/criteria/approach, create or update tests for new and impacted behavior, analyze regressions, and report validation evidence.
argument-hint: "[task slug or inline context with ## Inline Context header]"
---

# Implement

Run workflow implementation steps 8-9: implement planned changes, execute validations, and report regression impact.

Input (task slug, plan/requirements references, or inline context):
$ARGUMENTS

## Input Resolution

### Mode A — Inline Context

Activated when `$ARGUMENTS` contains a `## Inline Context` header.

Extract all implementation inputs directly from the provided content. The following sections are **required**:

| Section | Replaces | Purpose |
|---------|----------|---------|
| **Scope** | Requirements scope | What changes, what is out of scope |
| **Acceptance Criteria** | Requirements acceptance criteria + DoD | Testable conditions for "done" |
| **Implementation Approach** | Plan file | How to structure, phase, and test changes |

Optional sections: **External Reference** (URL to ticket), **Regression Concerns** (known risk areas).

**If any required section is missing, STOP and tell the user which section is absent. Do not proceed.**

### Mode B — Local Files (default)

Activated when a task slug or file paths are provided. Resolve inputs as:
- `workflow/plans/{task-name}.md`
- `workflow/requirements/{task-name}.md`

## Workflow

1. Load execution inputs.
- **Mode A**: extract Scope, Acceptance Criteria, and Implementation Approach from inline context.
- **Mode B**: read `workflow/plans/{task-name}.md` and `workflow/requirements/{task-name}.md` for validation reference.

2. Implement according to plan / approach.
- Apply code changes in small, coherent increments.
- Preserve project architecture and conventions.

3. Execute testing strategy.
- Add or update tests for all new behavior.
- Add or update tests for impacted existing behavior.
- If automated testing is unavailable for a scenario, run and document manual validation steps.

4. Analyze regressions.
- Identify pre-existing flows potentially impacted by the changes.
- In Mode A, use Regression Concerns (if provided) as additional input.
- Validate those flows explicitly.
- Record outcomes (`pass`/`fail`), evidence, and unresolved issues.

## Output Contract

Return sections in this order:

1. Implementation summary (`what changed` and `where`).
2. Test coverage summary (`new`, `updated`, `manual`).
3. Regression impact checklist and outcomes.
4. Outstanding risks and follow-ups.

## Quality Checks

- Do not introduce silent behavior changes.
- Keep validation directly traceable to planned scope and impact analysis.
- In Mode A, use acceptance criteria as the validation reference.
- Keep manual validation explicit, justified, and reproducible.
- Keep unresolved risks visible and actionable.
