# Adding an Atlas plugin

Atlas products are independently versioned and released. A catalog entry is accepted only after its product plugin repository is complete and its runtime delivery path is documented.

For each product release:

1. Publish an immutable plugin-only repository tag.
2. Keep the product runtime and licensed third-party content outside this marketplace repository.
3. Record plugin and runtime provenance once in `catalog.json`.
4. Run `scripts/generate-marketplaces.ps1` to generate Codex, Claude/Copilot, and ZCode records.
5. Keep plugin ordering consistent across every generated catalog.
6. Confirm the displayed version matches the plugin manifest and Git reference.
7. Document platform, application-build, runtime-access, authentication, signing, and licensing prerequisites.
8. Validate the product plugin before publishing the marketplace reference.

Do not maintain copies of product skills or MCP definitions here. Marketplace entries must reference the corresponding public `<Product>-Plugin` repository.
