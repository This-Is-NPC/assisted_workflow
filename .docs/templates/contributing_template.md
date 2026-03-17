# Contributing

## Commit Standards

- Use [Conventional Commits](https://www.conventionalcommits.org/).
- Write every commit message in English.
- Format: `type(scope): concise summary` or `type: concise summary`.
- Types: `feat`, `fix`, `docs`, `refactor`, `chore`, `test`, `build`, `ci`, `perf`.
- Breaking changes: add `!` after type/scope (e.g., `feat!: remove deprecated API`).

## Branch Naming

- Feature: `feature/{short-name}` (e.g., `feature/audio-badges`)
- Fix: `fix/{short-name}` (e.g., `fix/duplicate-insert`)
- Use lowercase kebab-case. Keep names short and descriptive.

## Workflow Templates

| Template | Path | Used by |
|----------|------|---------|
| Requirements | `.docs/templates/user_story_template.md` | `/requirements` |
| Plan | `.docs/templates/plan_template.md` | `/planning` |
| Summary | `.docs/templates/summary_template.md` | `/summarize` |

## Project Management

| Setting | Value |
|---------|-------|
| Tool | {GitHub Projects \| Azure DevOps \| Jira \| Linear \| None} |
| Access method | {CLI (gh, az, jira-cli) \| MCP server \| API \| Manual} |
| Project/Board URL | {URL or identifier} |
| How to read tasks | {e.g., `gh project item-list 1 --owner org` or MCP tool name} |
| How to create issues | {e.g., `gh issue create` or MCP tool name} |
| How to update status | {e.g., `gh project item-edit` or MCP tool name} |

## Code Standards

- {Language-specific conventions, linting rules, test framework, etc.}
- {Add project-specific patterns here}
