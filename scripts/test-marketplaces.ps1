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
$paths=@('.agents/plugins/marketplace.json','.claude-plugin/marketplace.json','.github/plugin/marketplace.json','marketplace.json','.cursor-plugin/marketplace.json')
foreach($path in $paths){
 $generated=Get-Content -LiteralPath (Join-Path $fixture $path) -Raw|ConvertFrom-Json
 $expected=@($catalog.plugins|Where-Object status -ne 'coming-soon')
 Check (@($generated.plugins).Count -eq $expected.Count -and $generated.plugins[0].name -eq 'hapatlas') "Released entries differ in $path"
 Check ((@($generated.plugins.name|Sort-Object) -join ',') -eq (@($expected.name|Sort-Object) -join ',')) "Wrong plugin identities in $path"
 Check ($generated.plugins[0].source.ref -eq $catalog.plugins[0].ref) "HAPAtlas pin changed in $path"
}
$rootManifest=Get-Content -LiteralPath (Join-Path $fixture 'marketplace.json') -Raw|ConvertFrom-Json
Check (![string]::IsNullOrWhiteSpace($rootManifest.owner.name)) 'Copilot/ZCode root owner missing'
$before=(Get-FileHash -LiteralPath (Join-Path $fixture $paths[0])).Hash
$bad=$catalog|ConvertTo-Json -Depth 30|ConvertFrom-Json
$bad.plugins[1].status='public-beta'
$bad.plugins[1].commit=$null
Write-Catalog $bad
$rejected=$false
try{& $generator -CatalogPath $inputPath}catch{if($_.Exception.Message -like 'PINNED_RELEASE_REQUIRED:*'){$rejected=$true}else{throw}}
Check $rejected 'Unpinned release was accepted'
Check ((Get-FileHash -LiteralPath (Join-Path $fixture $paths[0])).Hash -eq $before) 'Rejected catalog partially rewrote outputs'
$bad=$catalog|ConvertTo-Json -Depth 30|ConvertFrom-Json
$bad.plugins[1].status='coming-soon'
$bad.plugins[1].ref=$null
$bad.plugins[1].commit=$null
$bad.plugins[1].installable=$true
Write-Catalog $bad
$rejected=$false
try{& $generator -CatalogPath $inputPath}catch{if($_.Exception.Message -like 'UPCOMING_PLUGIN_CANNOT_HAVE_INSTALLATION_PIN:*'){$rejected=$true}else{throw}}
Check $rejected 'Upcoming plugin enabled installation'
@{passed=$checks;scope='Catalog generation and release gating';fixture=$fixture}|ConvertTo-Json
