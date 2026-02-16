# CLAUDE.md — Stocks Repository

## Project Overview

This is the **Stocks** repository (`batesbg/Stocks`). It is a new project; conventions described here should be followed as the codebase grows.

## Repository Structure

```
Stocks/
├── CLAUDE.md          # This file — guidance for AI assistants and contributors
└── (project files)    # To be added as the project develops
```

As the project evolves, update this section to reflect the actual directory layout (e.g., `src/`, `tests/`, `docs/`, `scripts/`, config files).

## Development Workflow

### Branching Strategy

| Branch pattern | Purpose |
|---|---|
| `main` | Stable, production-ready code |
| `claude/*` | AI-assisted feature/task branches |
| `feature/*` | Manual feature development |
| `fix/*` | Bug-fix branches |

- Always develop on a feature branch; never push directly to `main`.
- Open a pull request for review before merging into `main`.

### Commit Conventions

- Write clear, concise commit messages in the imperative mood (e.g., "Add portfolio summary endpoint").
- Keep commits atomic — each commit should represent a single logical change.
- Do not commit secrets, credentials, API keys, or `.env` files.

### Code Quality

- Run linters and formatters before committing (tools TBD as the project grows).
- Run the full test suite before pushing (testing framework TBD).
- Prefer small, focused pull requests over large monolithic changes.

## Key Conventions

### General

- Keep code simple and readable; avoid premature abstractions.
- Follow the project's chosen language style guide (to be established).
- Document public APIs and non-obvious logic with concise comments.
- Do not over-engineer — only build what is currently needed.

### Security

- Never commit API keys, tokens, passwords, or other secrets.
- Use environment variables or a secrets manager for sensitive configuration.
- Validate all external inputs at system boundaries.
- Be mindful of OWASP Top 10 vulnerabilities when handling user data.

### Testing

- Write tests for new functionality.
- Ensure existing tests pass before pushing changes.
- Name test files and functions clearly to describe what they verify.

## Useful Commands

> **Note:** Update this section as tooling is introduced (e.g., build commands, test runners, linters).

```bash
# Example placeholders — replace with actual commands as they are defined
# Run tests
# npm test / pytest / go test ./...

# Lint
# npm run lint / flake8 / golangci-lint run

# Build
# npm run build / make / go build ./...
```

## Notes for AI Assistants

- Read existing code before suggesting modifications.
- Prefer editing existing files over creating new ones.
- Do not add features, refactoring, or "improvements" beyond what is requested.
- Keep changes minimal and focused on the task at hand.
- Do not introduce new dependencies without explicit approval.
- Always verify that tests pass after making changes.
- When unsure about project conventions, check recent commits and existing code for patterns.
