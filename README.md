# Atlas Marketplace

Atlas Marketplace is the public catalog for independently installable engineering-agent plugins in the Atlas product family. Add this repository once in a supported client, then choose only the Atlas products you need.

## Available plugins

| Plugin | Version | Platform | Runtime |
|---|---:|---|---|
| [HAPAtlas](https://github.com/mroshdy91/HAPAtlas-Plugin) | `1.0.0-alpha.1` | Windows | Separate signed HAPAtlas product installation required |

Future products such as RevitAtlas, CADAtlas, CodeAtlas, and EliteFireAtlas can be added as independent entries without coupling their versions, runtimes, permissions, or supported application builds.

## Add the marketplace

### Codex

```text
codex plugin marketplace add mroshdy91/Atlas-Marketplace
```

Open `/plugins`, select **Atlas Marketplace**, and install `hapatlas`. Start a new session after installation.

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

Gemini CLI currently expects an extension manifest at the repository root, so each Atlas product retains its own installable plugin repository.

## Marketplace model

This repository contains catalogs and documentation only. It does not duplicate plugin skills, MCP definitions, product runtimes, licensed third-party application content, projects, reports, or support packages.

Each catalog entry points to a versioned public plugin repository:

```text
Private canonical product source
        ↓ generated release
Public <Product>-Plugin repository
        ↓ versioned marketplace entry
Atlas-Marketplace
```

Choose either this umbrella marketplace or a product-specific marketplace in one client profile. Installing the same product from both sources can create duplicate plugin registrations.
