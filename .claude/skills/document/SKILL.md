---
name: document
description: Analyze the codebase and produce architecture.md (tech stack, dependencies, patterns, auth, roles, code metrics) and requirements.md (functional, non-functional, business rules with file references). Use when the user asks to document project architecture, map implemented requirements, or generate a project knowledge base.
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
- Always inspect the test structure: presence/absence of tests, test directory layout, framework in use, how tests are invoked. Record this regardless of whether coverage can be measured.
- Gather code metrics. For each metric below: if the tool is already configured in the project, run it and record the exact command and value. If it is not configured (or tests do not exist for coverage/mutation), write a stack-specific **recommendation** — which tool, why it fits the detected stack, and a minimal setup hint. Do **not** install anything as part of `/document`.
  - Test coverage: e.g., `pytest --cov` (Python), `jest --coverage` / `vitest --coverage` (JS/TS), `go test -cover` (Go), `cargo tarpaulin` (Rust), `dotnet test --collect:"XPlat Code Coverage"` (.NET), `mvn jacoco:report` (Java/Maven).
  - Module sizes (LOC): e.g., `tokei`, `cloc`, `scc`. Report top-N largest modules/files.
  - Cyclomatic complexity: e.g., `radon cc` (Python), ESLint `complexity` rule (JS/TS), `gocyclo` (Go), `lizard` (polyglot), `PMD` (Java). Report top-N hotspots and threshold used.
  - Internal dependency structure: e.g., `madge` / `depcruise` (JS/TS), `pydeps` / `import-linter` (Python), `go list -deps` + `graphviz` (Go). Report circular dependency count and high fan-in modules.
  - Mutation score: e.g., `mutmut` / `cosmic-ray` (Python), `Stryker` (JS/TS/.NET), `PIT` (Java), `cargo-mutants` (Rust). Only when configured; otherwise recommend based on the detected stack.
- If no tests exist at all, still complete the metrics section: mark coverage/mutation as "not measurable — no test suite" and recommend a test framework that fits the detected stack.

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

## Code Metrics
| Metric | Status | Value / Finding | Source (tool + command) or Recommendation |
|--------|--------|-----------------|-------------------------------------------|
| Test structure | measured | {layout, framework, invocation} | {path + command} |
| Test coverage | measured \| recommended | {% or "no test suite"} | {command ran, OR tool recommended + why it fits the stack} |
| Module sizes (LOC) | measured \| recommended | {top-N list or —} | {command or recommendation} |
| Cyclomatic complexity | measured \| recommended | {top-N hotspots or —} | {command or recommendation} |
| Internal dependency structure | measured \| recommended | {circular deps count, high fan-in, or —} | {command or recommendation} |
| Mutation score | measured \| recommended | {% or "no test suite"} | {command or recommendation} |

Every row must be filled: either a measured value or a stack-specific recommendation. Do not remove rows.
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
- Test structure is always documented, even when no tests exist.
- Every metric row is either measured (with command) or recommended (with tool name + stack rationale). Never leave a metric silently omitted.
