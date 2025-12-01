# Repository Guidelines

## Project Structure & Module Organization

- `action.yml`: Composite GitHub Action installing Terragrunt and exposing outputs for version and binary path.
- `README.md`: Usage instructions for consumers of the action.
- `.github/FUNDING.yml`: Funding metadata only; no workflows are committed here. Add new workflows under `.github/workflows/` when needed for validation.

## Build, Test, and Development Commands

- `actionlint action.yml`: Lint the action definition for syntax and GitHub Actions best practices.
- `yamllint action.yml`: Optional YAML formatting check; keep indentation at two spaces.
- `act -W .github/workflows/<workflow>.yml`: Dry-run a workflow that consumes this action; create a temporary workflow in your branch or fork to exercise changes.
- `bash -euo pipefail <script>`: Use strict Bash when adding helper scripts; mirror the existing `shell: bash -euo pipefail {0}` style.

## Coding Style & Naming Conventions

- Prefer Bash that is POSIX-friendly and works on both amd64 and arm64 runners; gate architecture-specific logic behind `uname` checks as in `arch_type`.
- Keep input names kebab-case (`terragrunt-version`, `directory-path`) and document defaults in `README.md`.
- Outputs should be lowercase, hyphen-separated, and written via `GITHUB_OUTPUT`.
- Avoid hardcoding paths; honor the provided `directory-path` input and use `realpath` to surface absolute locations.

## Testing Guidelines

- There is no resident test suite; validate changes by running `act` against a minimal workflow that calls the action and confirms the downloaded binary and version strings.
- When touching download logic, test both `latest` and a pinned version (e.g., `v0.67.0`) on amd64 and arm64 runners.
- Capture failures early by checking exit codes and ensuring downloaded binaries are marked executable.

## Commit & Pull Request Guidelines

- Write imperative, concise commit messages (e.g., `Add arm64 download support`) and keep related changes in a single commit when feasible.
- PRs should describe what changed, why, and how it was validated (commands run, platforms tried); include snippets of `act` output if available.
- Link any related issues; add screenshots only if you introduce new README examples or workflow snippets.

## Security & Configuration Tips

- Prefer HTTPS download URLs and pin versions when feasible to improve reproducibility.
- Avoid embedding secrets; rely on GitHub-provided environment and inputs instead of hardcoded tokens or paths.
- Keep external dependencies minimal—`curl`, `jq`, and `realpath` are currently required; note any new tool dependencies in the README.

## Serena MCP Usage (Prioritize When Available)

- **If Serena MCP is available, use it first.** Treat Serena MCP tools as the primary interface over local commands or ad-hoc scripts.
- **Glance at the Serena MCP docs/help before calling a tool** to confirm tool names, required args, and limits.
- **Use the MCP-exposed tools for supported actions** (e.g., reading/writing files, running tasks, fetching data) instead of re-implementing workflows.
- **Never hardcode secrets.** Reference environment variables or the MCP’s configured credential store; avoid printing tokens or sensitive paths.
- **If Serena MCP isn’t enabled or lacks a needed capability, say so and propose a safe fallback.** Mention enabling it via `.mcp.json` when relevant.
- **Be explicit and reproducible.** Name the exact MCP tool and arguments you intend to use in your steps.

## Code Design Principles

Follow Robert C. Martin's SOLID and Clean Code principles:

### SOLID Principles

1. **SRP (Single Responsibility)**: One reason to change per class; separate concerns (e.g., storage vs formatting vs calculation)
2. **OCP (Open/Closed)**: Open for extension, closed for modification; use polymorphism over if/else chains
3. **LSP (Liskov Substitution)**: Subtypes must be substitutable for base types without breaking expectations
4. **ISP (Interface Segregation)**: Many specific interfaces over one general; no forced unused dependencies
5. **DIP (Dependency Inversion)**: Depend on abstractions, not concretions; inject dependencies

### Clean Code Practices

- **Naming**: Intention-revealing, pronounceable, searchable names (`daysSinceLastUpdate` not `d`)
- **Functions**: Small, single-task, verb names, 0-3 args, extract complex logic
- **Classes**: Follow SRP, high cohesion, descriptive names
- **Error Handling**: Exceptions over error codes, no null returns, provide context, try-catch-finally first
- **Testing**: TDD, one assertion/test, FIRST principles (Fast, Independent, Repeatable, Self-validating, Timely), Arrange-Act-Assert pattern
- **Code Organization**: Variables near usage, instance vars at top, public then private functions, conceptual affinity
- **Comments**: Self-documenting code preferred, explain "why" not "what", delete commented code
- **Formatting**: Consistent, vertical separation, 88-char limit, team rules override preferences
- **General**: DRY, KISS, YAGNI, Boy Scout Rule, fail fast

## Development Methodology

Follow Martin Fowler's Refactoring, Kent Beck's Tidy Code, and t_wada's TDD principles:

### Core Philosophy

- **Small, safe changes**: Tiny, reversible, testable modifications
- **Separate concerns**: Never mix features with refactoring
- **Test-driven**: Tests provide safety and drive design
- **Economic**: Only refactor when it aids immediate work

### TDD Cycle

1. **Red** → Write failing test
2. **Green** → Minimum code to pass
3. **Refactor** → Clean without changing behavior
4. **Commit** → Separate commits for features vs refactoring

### Practices

- **Before**: Create TODOs, ensure coverage, identify code smells
- **During**: Test-first, small steps, frequent tests, two hats rule
- **Refactoring**: Extract function/variable, rename, guard clauses, remove dead code, normalize symmetries
- **TDD Strategies**: Fake it, obvious implementation, triangulation

### When to Apply

- Rule of Three (3rd duplication)
- Preparatory (before features)
- Comprehension (as understanding grows)
- Opportunistic (daily improvements)

### Key Rules

- One assertion per test
- Separate refactoring commits
- Delete redundant tests
- Human-readable code first

> "Make the change easy, then make the easy change." - Kent Beck
