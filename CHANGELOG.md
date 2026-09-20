# Changelog

> Kontakt API Tools 0.1.0 substantially improves the API documentation, extension activation, and development workflow.

## [v0.1.0] - 2026-09-20

### Added
- Expanded the Kontakt, Filesystem, and MIR documentation with behavior details, units, index semantics, return values, and error conditions.
- Added literal types for MIR sample, drum, and instrument categories.
- Added smoke tests for the extension manifest, bundled definition files, and filesystem path handling.
- Added detection and guided correction of workspace-level `Lua.workspace.library` settings that hide the Kontakt definitions.

### Changed
- The extension now activates when a Lua file is opened instead of at every VS Code startup.
- LuaLS is now handled as a required extension dependency instead of being installed or activated manually.
- Bundled definitions are refreshed on version changes, by the initialize command, and on every Extension Development Host launch.
- Existing global LuaLS library entries are preserved, and `Lua.workspace.checkThirdParty` is no longer modified.
- `Kontakt.save_group` and `Kontakt.load_group` now correctly mark their `options` argument as optional.
- Extension packaging now excludes development-only files and unused assets.

### Fixed
- Prevented stale API definitions from surviving extension updates or development launches.
- Prevented workspace and folder settings from silently overriding the registered Kontakt library without a warning.
- Corrected Filesystem documentation for Boost.Filesystem behavior, including symlinks, empty files, paths, and error cases.
- Corrected MIR signatures and clarified the behavior and limitations of analysis functions.
- Removed a missing webview resource request and improved changelog error handling and cleanup.
