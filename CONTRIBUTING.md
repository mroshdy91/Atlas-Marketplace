# Adding an Atlas plugin

Atlas products are independently versioned and released. A new catalog entry is accepted only after its public plugin repository is complete and its runtime delivery path is documented.

For each product release:

1. Publish a versioned plugin-only repository or release tag.
2. Keep the product runtime and licensed third-party content outside this marketplace.
3. Update `catalog.json` from the product's canonical release metadata.
4. Generate the Codex, Claude/Copilot, and ZCode marketplace records from that metadata.
5. Keep plugin ordering consistent across every catalog.
6. Confirm the displayed version matches the plugin manifest and Git reference.
7. Document platform, application-build, runtime, authentication, and licensing prerequisites.

Do not maintain copies of product skills or MCP definitions in this repository. Marketplace entries must reference the corresponding public `<Product>-Plugin` repository.
