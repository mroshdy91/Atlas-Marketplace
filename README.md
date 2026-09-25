# Atlas Marketplace

Install the Atlas engineering plugins from this existing Git marketplace.

## Atlas for Revit — 2.0.0-alpha.1

**Windows x64, licensed Revit 2025 or 2026. Free personal and commercial use under the included terms.** The implementation source remains private. Public repositories contain client plugins, skills, installation helpers and compiled runtime releases.

| Plugin | Purpose | Dependency |
|---|---|---|
| [Atlas Core](https://github.com/mroshdy91/RevitAtlas.Core-Plugin) | Connection, work ownership, inspection, execution plans, checked scripting, review and delivery | Licensed Revit |
| [Atlas Family](https://github.com/mroshdy91/RevitAtlas.Family-Plugin) | Native family geometry, parameters, constraints and connectors | Atlas Core |
| [Atlas Sheets](https://github.com/mroshdy91/RevitAtlas.Sheets-Plugin) | Views, sheets and layout | Atlas Core |
| [Atlas Annotations](https://github.com/mroshdy91/RevitAtlas.Annotations-Plugin) | Tags, dimensions, text and detail content | Atlas Core |

The four plugins expose **26 tools** and share one Windows runtime. Core installs the matching engine for each installed Revit year. Specialists do not install separate engines. The legacy RevitAtlas MCP is not required.

### Install or update in Codex

Add this marketplace through the plugin marketplace interface, or use:

```text
codex plugin marketplace add mroshdy91/Atlas-Marketplace
```

Install **atlas-core** and the specialists you need. Then ask your agent:

> Set up or update Atlas for Revit and verify its connection.

The Core helper downloads the pinned [2.0.0-alpha.1 runtime](https://github.com/mroshdy91/RevitAtlas.Core-Plugin/releases/tag/v2.0.0-alpha.1), verifies its hashes, and configures the local connection. No GitHub account, private-source access, SDK or manual token copying is required. Save and close Revit normally when setup requests it. Reconnect or restart the AI client if requested, then open Revit.

**Upgrading from 0.1.0-beta.4:** update Core and all installed specialists together. The new v2 clients require the matching 2.0.0-alpha.1 runtime; the old beta runtime cannot serve the new interface. Existing credentials are preserved. Keep the installer receipt for rollback. Older immutable release tags and runtime assets remain available.

### Qualified scope and limits

This is a scoped **alpha**, not completion of the Grand Refactor or universal family qualification. Read the [exact qualification and limitations](https://github.com/mroshdy91/RevitAtlas.Core-Plugin/blob/v2.0.0-alpha.1/RELEASE-READINESS.md). Available actions exceed tested engineering scenarios; every delivered family still needs its own requirements, geometry and visual verification.

Revit 2026 currently has the qualified Mark-tag starter only. Recipe discovery does not qualify every recipe's execution. Checkpointed execution plans are enabled; single-document atomic plans are not enabled in this release. General MEP is outside these four plugins. Broader migration, recovery, performance and engineering-corpus work remains on the roadmap. The binaries are unsigned and remain subject to local Windows and organization policy.

### Other clients

See [client routes and evidence](CLIENTS.md). Compatible local clients use packaged connection formats or explicit exports. All connect to the same local Windows runtime. Installing a plugin in a cloud-only host cannot connect it to local Revit.

## HAPAtlas

[HAPAtlas](https://github.com/mroshdy91/HAPAtlas-Plugin) remains a separate Carrier HAP product at **1.0.0-alpha.1-private.1**, with its existing private-alpha runtime and access requirements. Its marketplace entry and immutable release pin are unchanged. Atlas for Revit setup does not install HAPAtlas.

## Repository layout

`catalog.json` owns the release pins. `scripts/generate-marketplaces.ps1` generates client-specific catalogs and rejects unpinned releases. The four public Revit plugin repositories share one private implementation repository. Public payloads exclude private evaluations, customer models, credentials and Autodesk API/template binaries.
