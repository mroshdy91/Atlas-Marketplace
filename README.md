# Atlas Marketplace

Atlas Marketplace is the public catalog for independently installable engineering-agent plugins in the Atlas product family. Add this repository once in a supported client, then choose only the Atlas products you need.

## Available plugins

| Plugin | Plugin version | Platform | Runtime |
|---|---:|---|---|
| [HAPAtlas](https://github.com/mroshdy91/HAPAtlas-Plugin) | `1.0.0-alpha.1-private.1` | Windows | Separate unsigned private runtime required |

HAPAtlas is currently a closed private Alpha. Anyone can inspect or add this public marketplace, but only authorized testers with access to the [private runtime prerelease](https://github.com/mroshdy91/HAPAtlas/releases/tag/v1.0.0-alpha.1-private.1) can connect the plugin to Carrier HAP.

Future products such as RevitAtlas, CADAtlas, CodeAtlas, and EliteFireAtlas can be added as independent entries without coupling their versions, runtimes, permissions, or supported application builds.

## Before installing HAPAtlas

Download, verify, extract, and install the separate private runtime by following [HAPAtlas-Plugin runtime instructions](https://github.com/mroshdy91/HAPAtlas-Plugin/blob/v1.0.0-alpha.1-private.1/RUNTIME.md). Restart the agent and confirm both commands succeed:

```powershell
hapatlas --version
hapatlas --doctor
```

Do not create a separate standalone/global HAPAtlas MCP entry. Every marketplace client launches the same bare `hapatlas` command supplied by the runtime installer.

## Add the marketplace

### Codex

```text
codex plugin marketplace add mroshdy91/Atlas-Marketplace
```

Open `/plugins`, select **Atlas Marketplace**, and install `hapatlas`. Restart Codex or start a new session afterward.

### Claude Code

```text
/plugin marketplace add mroshdy91/Atlas-Marketplace
/plugin install hapatlas@atlas-marketplace
```

### ZCode

Open **Settings → Plugins → Create → Add marketplace** and enter:

```text
https://github.com/mroshdy91/Atlas-Marketplace
```

Install and enable `hapatlas`, then restart or reload the Agent runtime.

### GitHub Copilot CLI

```text
copilot plugin marketplace add mroshdy91/Atlas-Marketplace
copilot plugin install hapatlas@atlas-marketplace
```

### Cursor, Gemini CLI, and Agent Plugins clients

These clients install the individual product package directly. For HAPAtlas, use:

```text
https://github.com/mroshdy91/HAPAtlas-Plugin
```

Gemini CLI currently expects the extension manifest at the product repository root, so each Atlas product retains its own installable plugin repository.

## Marketplace model

This repository contains generated catalogs and documentation only. It does not duplicate product skills, MCP definitions, runtimes, licensed third-party content, projects, reports, or support packages.

```text
Private product runtime and source
        ↓ immutable runtime handoff
Public <Product>-Plugin repository
        ↓ version-pinned marketplace entry
Atlas-Marketplace
```

Choose either this umbrella marketplace or a product-specific marketplace in one client profile. Installing the same product from both sources can create duplicate plugin registrations.

`catalog.json` is the canonical marketplace source. `scripts/generate-marketplaces.ps1` generates every thin client-specific marketplace record from it.
