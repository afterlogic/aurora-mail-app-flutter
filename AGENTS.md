# AGENTS.md

Instructions for AI agents working in this repository.

## Language

Files committed to this repository must not contain Russian text. English only, even though the team communicates in Russian in chat.

## Branding / build_variant

This project uses the `build_variant` tool (`sh/build_variant.sh`, `build_variant.yaml`) to generate `pubspec.yaml` and other files from templates (`pubspec.yaml.yaml`, `AndroidManifest.xml.temp`, etc.) for a specific brand (`build_res/<brand>/...`).

- **The default and only committable brand is `afterlogic`.** If, after a rebuild/regeneration (`pub get`, a manual `build_variant` run, an IDE file watcher firing, etc.), `pubspec.yaml`/generated files end up containing `afterlogic` (paths like `build_res/afterlogic/...`, `description: Mail client for Aurora Mail.`, etc.) — that is the **expected, correct** state, not a regression. Do not revert it to other brand.
- During final review before a commit, **do not change branding away from `afterlogic`**.
- !! **Only commit with `afterlogic` branding.** A `brand` (or other brand) state is local/temporary for testing a specific installation and must never be committed.

## Handling API request examples from the user

If the user provides an example of a working API request (curl, wget, a browser/proxy capture, etc.), **trust that example** as the source of truth for the exact request shape (field names, headers, body structure) — do not rely on assumptions, old code, or other sources, even if they seem logical. Reconcile the app's implementation with exactly the example the user showed.
