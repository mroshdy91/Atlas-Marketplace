# Client installation and connection

The current Revit plugin and runtime release is **2.0.0-alpha.1**. Update Core and installed specialists together. Each public plugin repository includes its client manifests and an exact `CLIENTS.md` for this release.

| Client format | Packaged route | Qualification statement |
|---|---|---|
| Codex | `.codex-plugin/plugin.json` with its inline HTTP connection; add this Git marketplace | Installed clients and native Revit 2025/2026 scenarios checked |
| Claude Code | `.claude-plugin/plugin.json` and `.mcp.json` | v2 portable transport checked; no new claim of full client-specific native qualification |
| ZCode / Cursor | Client-specific plugin manifests | Packaging supplied; qualify the installed client separately |
| Agent Plugins | `plugin.json` and `mcp.json` | Portable local connection format |
| Gemini / Qwen | Client-specific extension manifests | Packaging supplied; qualify the installed client separately |
| VS Code, OpenCode, Continue, Antigravity and other MCP clients | Core's `scripts/atlas-client-config.ps1` exports | Merge through the client's supported local configuration flow; do not overwrite other servers |

Use a local Windows execution host on the same account and PC as Revit. Core provisions the credential; never paste it into configuration or expose the broker publicly. Non-HTTP clients use the packaged PowerShell stdio adapter, which forwards to the same shared broker. Marketplace discovery, connection, and successful engineering authoring are distinct evidence levels.

The [previous beta client research and checks](docs/history/CLIENTS-0.1.0-beta.4.md) are retained as history. They do not automatically qualify this new v2 release in each client. Vendor gallery acceptance and cloud-hosted use remain separate from installation through this Git marketplace.

HAPAtlas retains its own client instructions and private-alpha runtime requirements.
