# Commit Messages

## Subject Line

- **Prefix**: Area(s) touched, followed by a colon and space.
  - Go code: use the package path (e.g. `cmd/foo:`, `pkg/bar:`).
  - Non-Go directories: use the top-level name (e.g. `docs:`, `scripts:`).
  - Multiple areas: comma-separated (e.g. `cmd,pkg:`).
  - Broad refactors: use `*:`.
- **Verb**: Imperative mood, capitalized (e.g. `Add`, `Fix`, `Remove`).
- **Length**: Keep under 50 characters (including prefix) when possible.

## Body

- Blank line between subject and body.
- **Motivate first**: Explain *why* the change is being made.
- **Then state what**: Summarize what was changed.
- Wrap lines at 72 characters.

## Trailers

- Always include the `Co-Authored-By:` trailer when Claude contributed to the
  commit.

## Example

```
cmd/foo,docs: Add foo command and usage docs

The project needed a CLI entry point for foo and corresponding
documentation for users.

Add the foo subcommand with flag parsing and a docs page covering
usage and configuration.

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```
