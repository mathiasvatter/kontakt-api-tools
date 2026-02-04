# Changelog

> Thanks for using the Kontakt Lua API VS Code extension! This small update contains updates to the API definition files, like updating function signatures, incomplete documentation, and adding missing functions. Enjoy!

## [v0.0.2] - 2026-02-04

### Added
- Added missing function `set_voice_groups` to the Kontakt API definitions.
- Defined return types for `Kontakt.add_instrument`, `Kontakt.add_instrument_bank`, and `Kontakt.load_instrument` to improve IntelliSense accuracy.

### Changed
- Updated documentation for `load_snapshot`, `save_instrument`, and `save_snapshot` functions for clarity and completeness.
- Replaced `@type` annotations with `@class` to fix an issue where method autocompletion wasn't working properly.
- Improved `@param` documentation across several functions for better developer guidance.
