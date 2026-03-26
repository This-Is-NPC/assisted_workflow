---
name: document
description: Analyze the codebase and produce architecture.md (tech stack, dependencies, patterns, auth, roles) and requirements.md (functional, non-functional, business rules with file references). Use when the user asks to document project architecture, map implemented requirements, or generate a project knowledge base.
argument-hint: "[optional focus area or additional context]"
model-tier: large
---

# Document

Analyze the current codebase to produce two reference artifacts: an architecture overview and an implemented-requirements map.

Additional context (optional):
$ARGUMENTS

## Workflow

0. Read `CONTRIBUTING.md` for project standards and conventions.

1. Analyze the codebase thoroughly.
- Inspect dependency manifests (package.json, requirements.txt, go.mod, Cargo.toml, Gemfile, pom.xml, *.csproj, etc.) for stack and version data.
- Inspect project structure, entry points, configuration files, and middleware.
- Identify patterns (MVC, hexagonal, CQRS, event-driven, etc.) from actual code organization.
- Identify authentication mechanism and implementation (JWT, OAuth, session, etc.) if present.
- Identify role/permission system and map each role to its privileges if present.
- Identify design system or UI component library if present.
- Identify infrastructure and deployment configuration (Docker, CI/CD, cloud services) if present.

2. Create `architecture.md` in the project documentation directory (default: `.docs/`).
- Document **only** what is verifiable in the codebase or provided as context by the user.
- Use the structure defined in the **Architecture Document Structure** section below.
- Keep content concise — prefer tables and lists over prose.
- Every claim must be traceable to a file or configuration in the repository.

3. Analyze implemented requirements.
- Walk through routes, controllers, services, models, and tests to extract functional behavior.
- Identify non-functional characteristics from configuration, middleware, and infrastructure (caching, rate limiting, logging, monitoring, etc.).
- Identify business rules from validation logic, domain models, and conditional flows.
- **No assumptions** — only document behavior that is implemented in code or explicitly provided by the user.
- Record source file references for each identified item.

4. Create `requirements.md` in the same documentation directory as `architecture.md`.
- Use the structure defined in the **Requirements Document Structure** section below.
- Every requirement must include at least one file reference where the behavior is implemented.
- Mark items provided by the user (not found in code) with `[user-provided]`.

5. Present summary and request confirmation.
- Provide a concise summary of both documents to the user.
- List key findings: stack, main patterns, auth mechanism, role count, and requirement counts (functional / non-functional / business rules).
- Ask the user to review both files and confirm or request corrections.
- Apply corrections if requested and re-confirm.

## Architecture Document Structure

```markdown
# Architecture

## Tech Stack
| Layer | Technology | Version |
|-------|-----------|---------|

## Dependencies
| Dependency | Version | Purpose |
|-----------|---------|---------|

## Project Structure
Brief description of directory layout and responsibility of each top-level directory.

## Architectural Patterns
List of identified patterns with brief rationale and where they are applied.

## Authentication
Mechanism, flow, and relevant files. Omit section if not applicable.

## Authorization / Roles
| Role | Privileges | Defined in |
|------|-----------|------------|
Omit section if not applicable.

## Design System / UI
Library or framework, component conventions. Omit section if not applicable.

## Infrastructure
Deployment, CI/CD, containerization, cloud services. Omit section if not applicable.
```

## Requirements Document Structure

```markdown
# Implemented Requirements

## Functional Requirements
| ID | Description | Source files |
|----|------------|-------------|

## Non-Functional Requirements
| ID | Description | Source files |
|----|------------|-------------|

## Business Rules
| ID | Rule | Source files |
|----|------|-------------|
```

Use sequential IDs per section: `FR-001`, `NFR-001`, `BR-001`.

## Output Contract

Return sections in this order:

1. Architecture summary (stack, key patterns, auth/roles overview).
2. Requirements summary (count per category, notable findings).
3. File paths for both generated documents.
4. Explicit confirmation request to the user.

## Quality Checks

- Never assume — every documented item must be backed by code or user-provided context.
- Never invent versions — read them from manifest files.
- Omit architecture sections that do not apply rather than writing "N/A".
- Keep both documents concise and scannable (tables over paragraphs).
- File references must use repository-relative paths.
- Do not proceed past the summary without user confirmation.
