# Repository Guidelines

## Project Structure & Module Organization
- Keep configuration files grouped by tool to stay discoverable. Suggested layout: `shell/` (bash/zsh rc files), `git/` (gitconfig, gitignore), `editor/` (vim/neovim), `bin/` (helper scripts), `install/` (bootstrap or stow scripts). Create folders as needed; avoid scattering dotfiles at the repo root.
- Prefer small, composable files (e.g., split shell aliases, functions, and exports) and document any cross-file dependencies in a short comment at the top of the file.

## Build, Test, and Development Commands
- No build step today. After changes, run quick hygiene checks that match what you touched:
  - `shellcheck bin/*.sh` for shell scripts.
  - `npm test` or `pytest` if you introduce JS/Python utilities with package manifests.
  - `sh install/bootstrap.sh` (if added) to confirm the bootstrap flow completes without prompts.

## Coding Style & Naming Conventions
- Shell: 2-space indent, `set -euo pipefail` for non-trivial scripts, favor long option names, and quote variables defensively.
- Scripts in `bin/` should be executable, start with a shebang, and use descriptive, kebab-case filenames (e.g., `sync-dotfiles`).
- Keep configs declarative where possible; avoid hard-coding absolute paths—use `$HOME` or relative paths from the repo root.
- If you introduce formatters/linters (e.g., `shfmt`, `prettier`, `black`), add a one-liner in this file so others can run them.

## Testing Guidelines
- Add lightweight tests for automation scripts. Prefer `bats` for shell or the native framework of the language you introduce.
- Name tests after the behavior they assert (`sync_creates_symlinks`, `install_skips_existing_files`).
- Strive for practical coverage of edge cases (missing dependency, existing dotfile, dry-run).

## Commit & Pull Request Guidelines
- Use clear, present-tense commit messages; Conventional Commits (`feat:`, `fix:`, `chore:`) are preferred for easy scanning.
- Keep commits small and reversible; separate refactors from behavioral changes.
- Pull requests should include: summary of changes, manual/test commands run, any new dependencies, and screenshots or terminal output when UI/CLI behavior changes.

## Security & Configuration Tips
- Never commit secrets or personal tokens. Store machine-specific values in a local override file ignored by git (e.g., `.env.local`, `private/`).
- Before adding a new tool, note required packages and minimum versions; prefer portable commands available on macOS and common Linux distros.
