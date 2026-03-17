---
name: prepare
description: Create implementation preparation artifacts from approved requirements. Use when a user asks to convert requirements into a project management issue and generate or create the implementation branch using workflow naming rules.
argument-hint: "[requirements doc path or task slug]"
model-tier: small
---

# Prepare

Run the preparation phase from the official workflow: create a project management issue from requirements and create or define the implementation branch.

Input (requirements doc path or task slug):
$ARGUMENTS

If a task slug is provided, resolve it to `workflow/requirements/{task-name}.md`.

## Workflow

0. Read `CONTRIBUTING.md` for project standards, template paths, and tool configuration. Use the **Project Management** section to determine which tool and access method to use for issue creation and status updates.
1. Load requirements source.
- Read `workflow/requirements/{task-name}.md`.
- Extract context, scope, acceptance criteria, and Definition of Done.

2. Build issue content.
- Title: start with a lowercase action verb (`add`, `fix`, `remove`, `replace`, `update`) + what is affected + where or why. Keep under ~60 characters.
  - Good: `add retry logic to payment webhook`, `fix duplicate insert on concurrent signup`
  - Avoid: vague (`update auth`), abstract (`improve system resilience`), or overly long titles.
- Body: follow the user story template defined in `CONTRIBUTING.md` Workflow Templates section.
- Keep issue text 1:1 aligned with requirements.

3. Create issue or provide creation instructions.
- Use the tool and access method defined in `CONTRIBUTING.md` Project Management section.
- If tooling/access is available, create the issue and capture issue number + URL.
- If tooling/access is unavailable, return exact issue title/body and exact command(s) to create it.

4. Create branch or provide branch command.
- Read branch naming conventions from `CONTRIBUTING.md`.
- If possible, create the branch.
- If not possible, provide exact branch creation command.

## Output Contract

Return sections in this order:

1. Issue title and body used.
2. Issue status:
- issue number + URL when created
- or pending creation instructions
3. Branch status:
- branch name
- created/not-created state
- exact command when manual creation is required

## Quality Checks

- Keep strict traceability to requirements.
- Keep branch names short, descriptive, and in kebab-case.
- Never add scope not present in requirements.
- Never include local file paths (e.g., `workflow/requirements/`, `workflow/plans/`) in issue content sent to external tools.
