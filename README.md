# Kontakt API Tools (VS Code Extension)

This extension provides language support for developing Lua scripts that use the Native Instruments Kontakt Lua API.

It is a **drop-in extension** that supplies **EmmyLua definition files** to the Lua Language Server, enabling proper code completion, suggestions, hover information and editor support when working with Kontakt Lua scripts.

This makes writing scripts for the Kontakt Lua API much easier and more productive without constantly having to refer to the (partly incomplete) external online documentation.

Additionally, since this is basically an add-on for the Lua Language Server, it needs the [Lua Language Server extension](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) to be installed and enabled in VS Code. If you don’t have it yet, you will be prompted to install it when you install this extension.



## Why this extension?

Native Instruments exposes a Lua API for Kontakt, but no official language-server-compatible definitions are available.

As a result, Lua scripts written for Kontakt lack:
- Autocompletion
- Inline/Hover documentation
- Type information
- Go-to-definition support

This extension fills that gap by providing definition files based on the official Kontakt API reference, additional testing, and legacy documentation (Creator Tools).

![Autocomplete- and Signature-Help example](media/gifs/kontakt-api-autocomplete.gif)
Auto completion and signature help in action. This helps you discover functions and their parameters quickly while you type.

![Hover Documentation example](media/gifs/kontakt-api-hover-doc.gif)
Hover documentation providing function descriptions and parameter info when hovering over API symbols.


## Features

- Full Kontakt Lua API definitions for Lua Language Server (LuaLS / sumneko)
- Autocompletion for functions, fields, and constants
- Hover documentation for API symbols
- Go-to-definition support
- EmmyLua-compatible type annotations
- Zero configuration required



## Requirements

- Visual Studio Code
- Lua Language Server (LuaLS / `sumneko.lua`)

> ⚠️ This extension will install/enable the Lua Language Server extension if it is not already present.


## How it works

This extension ships a set of EmmyLua-compatible definition files describing the Kontakt Lua API.

On activation, these definitions are automatically registered with the Lua Language Server using VS Code’s workspace library mechanism.


## Usage

Once installed, editor features are automatically available when editing `.lua` files.

Example:

```lua
local ks = Kontakt
local inst_name = ks.get_instrument_name(0)
print("Instrument Name: " .. inst_name)

ks.set_instrument_volume(0, 0.0)
ks.set_instrument_pan(0, 0.0)
```

You should see:
- Autocompletion while typing
- Hover documentation on API symbols
- Go-to-definition for Kontakt API functions and fields


## API Coverage

The extension covers the publicly documented Kontakt Lua API, including the following modules:

- Kontakt
- Multi
- Instrument
- Group
- Zone
- Filesystem
- MIR

### Notes on completeness

The official Kontakt API documentation is incomplete in some areas. Where possible, I added missing or undocumented functions (e.g. parts of the Filesystem module) based on:

- Empirical testing
- Creator Tools documentation
- Real-world usage in production scripts


## Open Source

This extension is fully open source.

Contributions are welcome, especially:
- API corrections
- Missing or newly discovered functions
- Documentation improvements


## References

- Native Instruments Kontakt API Reference
- Lua Language Server (EmmyLua)

