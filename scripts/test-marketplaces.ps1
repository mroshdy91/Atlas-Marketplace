[CmdletBinding()]
param()
$ErrorActionPreference='Stop'
$root=Split-Path $PSScriptRoot -Parent
$catalog=Get-Content -LiteralPath (Join-Path $root 'catalog.json') -Raw|ConvertFrom-Json
$fixture=Join-Path ([IO.Path]::GetTempPath()) ('AtlasMarketplaceTests-'+[Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path (Join-Path $fixture 'scripts') -Force|Out-Null
$generator=Join-Path $fixture 'scripts/generate-marketplaces.ps1'
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'generate-marketplaces.ps1') -Destination $generator
$inputPath=Join-Path $fixture 'catalog.json'
function Write-Catalog($value){[IO.File]::WriteAllText($inputPath,($value|ConvertTo-Json -Depth 30))}
$checks=0
function Check([bool]$condition,[string]$message){if(!$condition){throw $message};$script:checks++}
Write-Catalog $catalog
& $generator -CatalogPath $inputPath
$paths=@('.agents/plugins/marketplace.json','.claude-plugin/marketplace.json','.github/plugin/marketplace.json','marketplace.json')
foreach($path in $paths){
 $generated=Get-Content -LiteralPath (Join-Path $fixture $path) -Raw|ConvertFrom-Json
 Check (@($generated.plugins).Count -eq 1 -and $generated.plugins[0].name -eq 'hapatlas') "Unreleased entries leaked into $path"
 Check ($generated.plugins[0].source.ref -eq $catalog.plugins[0].ref) "HAPAtlas pin changed in $path"
}
$before=(Get-FileHash -LiteralPath (Join-Path $fixture $paths[0])).Hash
$bad=$catalog|ConvertTo-Json -Depth 30|ConvertFrom-Json
$bad.plugins[1].status='public-beta'
Write-Catalog $bad
$rejected=$false
try{& $generator -CatalogPath $inputPath}catch{if($_.Exception.Message -like 'PINNED_RELEASE_REQUIRED:*'){$rejected=$true}else{throw}}
Check $rejected 'Unpinned release was accepted'
Check ((Get-FileHash -LiteralPath (Join-Path $fixture $paths[0])).Hash -eq $before) 'Rejected catalog partially rewrote outputs'
$bad=$catalog|ConvertTo-Json -Depth 30|ConvertFrom-Json
$bad.plugins[1].installable=$true
Write-Catalog $bad
$rejected=$false
try{& $generator -CatalogPath $inputPath}catch{if($_.Exception.Message -like 'UPCOMING_PLUGIN_CANNOT_HAVE_INSTALLATION_PIN:*'){$rejected=$true}else{throw}}
Check $rejected 'Upcoming plugin enabled installation'
@{passed=$checks;scope='Catalog generation and release gating';fixture=$fixture}|ConvertTo-Json
