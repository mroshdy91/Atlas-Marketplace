[CmdletBinding()]
param(
    [string]$CatalogPath = (Join-Path (Split-Path $PSScriptRoot -Parent) 'catalog.json')
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
$catalog = Get-Content -LiteralPath $CatalogPath -Raw | ConvertFrom-Json
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

function Write-JsonFile {
    param(
        [Parameter(Mandatory)] [string]$RelativePath,
        [Parameter(Mandatory)] $Value
    )

    $path = Join-Path $repoRoot $RelativePath
    $directory = Split-Path $path -Parent
    [System.IO.Directory]::CreateDirectory($directory) | Out-Null
    $json = $Value | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($path, $json + "`n", $utf8NoBom)
}

$codexPlugins = @(
    foreach ($plugin in $catalog.plugins) {
        [ordered]@{
            name = $plugin.name
            source = [ordered]@{
                source = 'url'
                url = "$($plugin.repository).git"
                ref = $plugin.ref
            }
            policy = [ordered]@{
                installation = 'AVAILABLE'
                authentication = 'ON_INSTALL'
            }
            category = $plugin.category
        }
    }
)
Write-JsonFile '.agents/plugins/marketplace.json' ([ordered]@{
    name = $catalog.name
    interface = [ordered]@{ displayName = $catalog.display_name }
    plugins = $codexPlugins
})

$claudePlugins = @(
    foreach ($plugin in $catalog.plugins) {
        [ordered]@{
            name = $plugin.name
            source = [ordered]@{
                source = 'url'
                url = "$($plugin.repository).git"
                ref = $plugin.ref
                sha = $plugin.commit
            }
            description = $plugin.description
            version = $plugin.version
            category = $plugin.marketplace_category
            keywords = @($plugin.keywords)
        }
    }
)
Write-JsonFile '.claude-plugin/marketplace.json' ([ordered]@{
    '$schema' = 'https://anthropic.com/claude-code/marketplace.schema.json'
    name = $catalog.name
    owner = [ordered]@{ name = $catalog.owner.name; url = $catalog.owner.url }
    metadata = [ordered]@{ description = $catalog.description; version = $catalog.catalog_version }
    plugins = $claudePlugins
})

$copilotPlugins = @(
    foreach ($plugin in $catalog.plugins) {
        [ordered]@{
            name = $plugin.name
            source = [ordered]@{
                source = 'github'
                repo = $plugin.source_repo
                ref = $plugin.ref
            }
            description = $plugin.description
            version = $plugin.version
        }
    }
)
Write-JsonFile '.github/plugin/marketplace.json' ([ordered]@{
    name = $catalog.name
    owner = [ordered]@{ name = $catalog.owner.name; url = $catalog.owner.url }
    metadata = [ordered]@{ description = $catalog.description; version = $catalog.catalog_version }
    plugins = $copilotPlugins
})

$zcodePlugins = @(
    foreach ($plugin in $catalog.plugins) {
        [ordered]@{
            name = $plugin.name
            version = $plugin.version
            description = $plugin.description
            category = $plugin.marketplace_category
            tags = @($plugin.keywords)
            source = [ordered]@{
                source = 'github'
                repo = $plugin.source_repo
                ref = $plugin.ref
            }
            homepage = $plugin.repository
            repository = $plugin.repository
        }
    }
)
Write-JsonFile 'marketplace.json' ([ordered]@{
    name = $catalog.name
    description = $catalog.description
    plugins = $zcodePlugins
})

Write-Host "Generated $($catalog.plugins.Count) Atlas marketplace plugin record(s) from catalog $($catalog.catalog_version)."
