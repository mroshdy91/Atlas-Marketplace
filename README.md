# Atlas Marketplace

Add this marketplace once, then install the engineering tools you need.

## RevitAtlas public beta

**Free for personal and commercial use. Windows x64, Revit 2025 and 2026.** The implementation source is private; public repositories supply plugins, guidance, setup helpers and compiled releases.

| Plugin | Purpose | Requires |
|---|---|---|
| [Atlas Core](https://github.com/mroshdy91/RevitAtlas.Core-Plugin) | Connection, work identity, inspection, review, recovery and delivery | Licensed Revit |
| [Atlas Family](https://github.com/mroshdy91/RevitAtlas.Family-Plugin) | Native loadable-family authoring and editing | Atlas Core |
| [Atlas Sheets](https://github.com/mroshdy91/RevitAtlas.Sheets-Plugin) | Drawing views, sheets and layout | Atlas Core |
| [Atlas Annotations](https://github.com/mroshdy91/RevitAtlas.Annotations-Plugin) | Tags, dimensions, text and annotations | Atlas Core |

All four use **one shared Windows runtime**, distributed by Core. Specialists do not launch separate brokers or install separate engines. Sheets and Annotations can work on existing project content without Family.

### Install in Codex

Add `mroshdy91/Atlas-Marketplace` through the plugin marketplace interface, or run:

```text
codex plugin marketplace add mroshdy91/Atlas-Marketplace
```

Install **atlas-core** plus the specialists you need. Then ask your agent:

> Set up RevitAtlas and check its connection to Revit.

The agent follows the packaged Core skill, downloads the pinned public runtime, verifies its hashes and configures the local connection. You do not need a private-repository invitation, SDK, manual token entry or copied installation commands. Licensed Revit must already be installed. Save and close Revit when setup requests it; restart your AI client once if requested, then open Revit.

Marketplace installation supplies the plugin. The one-time Windows setup supplies the native Revit integration. See [runtime installation](https://github.com/mroshdy91/RevitAtlas.Core-Plugin/blob/v0.1.0-beta.1/RUNTIME.md). Unsigned binaries remain subject to Windows and organization security policy.

### Scope

Client packages **0.1.0-beta.3** reuse shared native runtime **0.1.0-beta.1**. This is a scoped public beta. Qualification covers specific native family and drawing workflows on both Revit versions; it does not claim every Revit operation, every family type or a completed 15-delivery production benchmark. Review [qualification and limitations](https://github.com/mroshdy91/RevitAtlas.Core-Plugin/blob/v0.1.0-beta.1/RELEASE-READINESS.md). Ordinary drawing edits preserve existing issue history; formal revision/cloud authoring and schedule authoring remain outside the exposed documentation scope.

## HAPAtlas

[HAPAtlas](https://github.com/mroshdy91/HAPAtlas-Plugin), version **1.0.0-alpha.1-private.1**, remains a separate Carrier HAP product with its existing private-alpha runtime and access requirements. Its release pin is unchanged. Follow [HAPAtlas runtime instructions](https://github.com/mroshdy91/HAPAtlas-Plugin/blob/v1.0.0-alpha.1-private.1/RUNTIME.md). RevitAtlas setup does not install HAPAtlas.

## Other clients and repository layout

Use [the client installation guide and evidence table](CLIENTS.md) for Codex, Claude Code, ZCode, Cursor, Copilot, VS Code, Factory, Qwen, Gemini, Kiro, Hermes, OpenClaw and other Agent Plugins clients. Antigravity and MCP-only clients have explicit exports. Each route states what was actually tested; adding a Git marketplace is not supported by every product or plan. Curated vendor galleries require their own acceptance.

Claude Code, Gemini and Qwen passed four-plugin connection checks; Codex retains native two-version evidence and passes updated installed-client checks. Copilot/ZCode installation and discovery passed, with remaining live-test limits documented. Other researched formats remain unqualified in their individual clients. Local Windows execution is required. Cloud-only agents cannot reach Revit merely by adding this marketplace.

Non-HTTP clients use one short-lived connection process per active Revit plugin. All still share one broker and the same version-matched Revit engine. Credentials are provisioned by Core and never pasted into client configuration.

`catalog.json` is the source of truth. `scripts/generate-marketplaces.ps1` generates the client catalogs and rejects unpinned releases. The four public Revit plugin repositories share one private implementation repository. No engine source, credentials, private evaluations, customer models or Autodesk binaries are included in public distribution.
