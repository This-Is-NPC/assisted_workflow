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
| Tool | GitHub Projects |
| Access method | CLI (`gh`) |
| Project/Board URL | — |
| How to read tasks | `gh project item-list <number> --owner <org>` |
| How to create issues | `gh issue create` |
| How to update status | `gh project item-edit` |

## Code Standards

- Markdown-based documentation project.
- Skills are authored in Markdown with YAML frontmatter.
- All skill content is in English.
- Canonical skill source: `src/skills/{name}/SKILL.md`.
- Run `bash scripts/sync-skills.sh` after editing any skill to propagate to all agent directories.
