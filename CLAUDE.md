# CLAUDE.md — 3D Printer Prototypes

## Project Overview

This repository contains **OpenSCAD** designs for 3D printer prototypes. Each prototype lives in its own subdirectory under `prototypes/` with a `.scad` source file and any supporting files.

## Repository Structure

```
Stocks/
├── CLAUDE.md              # This file — guidance for AI assistants and contributors
├── .gitignore             # Ignores generated STL/PNG files
├── prototypes/            # One subdirectory per prototype design
│   └── <name>/
│       ├── <name>.scad    # Main OpenSCAD source file
│       └── README.md      # (optional) Notes, print settings, photos
└── libraries/             # Shared OpenSCAD modules and functions
```

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

## OpenSCAD Conventions

- Use **millimeters** as the unit of measurement (OpenSCAD default).
- Parameterize dimensions with variables at the top of the file so designs are easy to customize.
- Use `$fn` (or `$fa`/`$fs`) to control resolution; set a reasonable default (e.g., `$fn = 50`).
- Name modules descriptively (e.g., `phone_stand_base()`, not `part1()`).
- Add a comment block at the top of each `.scad` file describing what the prototype is and key dimensions.

## Useful Commands

```bash
# Render a prototype to STL from the command line
openscad -o output.stl prototypes/<name>/<name>.scad

# Render a preview PNG
openscad --camera=0,0,0,55,0,25,200 --imgsize=800,600 -o preview.png prototypes/<name>/<name>.scad
```

## Notes for AI Assistants

- Read existing code before suggesting modifications.
- Prefer editing existing files over creating new ones.
- Do not add features, refactoring, or "improvements" beyond what is requested.
- Keep changes minimal and focused on the task at hand.
- Do not introduce new dependencies without explicit approval.
- Always verify that tests pass after making changes.
- When unsure about project conventions, check recent commits and existing code for patterns.
