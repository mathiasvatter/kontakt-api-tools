# Changelog

This is the initial release of the Kontakt Lua API VS Code extension.

## [0.0.1] - 2026-01-20

### Added
- Initial release of the VS Code extension for **Kontakt Lua API**.
- IntelliSense support through type definitions for `Kontakt`, `Filesystem`, and `MIR` modules. Collecting definitions, type infos and documentation into lua definition files, sourced from official API reference and Creator Tools documentation.
- Functionality for checking and **automatic installation** of the Lua Language Server (LLS) plugin by `sumneko.lua` at extension startup.
- Functionality for registering Kontakt Lua API definitions with LLS using VS Code's workspace library mechanism.
- Basic README documentation outlining features, requirements, and usage.
- Logger system integrated into the VS Code Output tab for easier debugging (replaces `console.log` usage).
- **Changelog webview component** embedded in the extension for displaying release notes.

> Note: The definition files might be incomplete in some areas or incorrectly annotated. Contributions and issue reports are welcome!