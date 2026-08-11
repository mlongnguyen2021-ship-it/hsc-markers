#requires -Version 5.1

[CmdletBinding()]
param(
    [ValidateSet('Codex', 'ClaudeCode')]
    [string]$Target = 'Codex',

    [string]$DestinationRoot,

    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    $userProfile = [Environment]::GetFolderPath('UserProfile')
    if ($Target -eq 'Codex') {
        $DestinationRoot = if ($env:CODEX_HOME) {
            $env:CODEX_HOME
        } else {
            Join-Path $userProfile '.codex'
        }
    } else {
        $DestinationRoot = Join-Path $userProfile '.claude'
    }
}

$destinationRootFull = [IO.Path]::GetFullPath($DestinationRoot)
$skillDestination = Join-Path $destinationRootFull 'skills\mark-hsc-biology'
$sourceDestination = Join-Path $destinationRootFull 'sources\biology'
$existing = @($skillDestination, $sourceDestination)
$existing = @($existing | Where-Object { Test-Path -LiteralPath $_ })

if ($existing.Count -gt 0 -and -not $Force) {
    throw "Already installed at $($existing -join ', '). Re-run with -Force to update it."
}

$archiveUrl = 'https://github.com/mlongnguyen2021-ship-it/hsc-markers/archive/refs/heads/main.zip'
$tempBase = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
$tempRoot = Join-Path $tempBase "hsc-markers-$([Guid]::NewGuid().ToString('N'))"
$archivePath = Join-Path $tempRoot 'hsc-markers.zip'
$extractPath = Join-Path $tempRoot 'expanded'

function Copy-Tree {
    param(
        [Parameter(Mandatory)] [string]$Source,
        [Parameter(Mandatory)] [string]$Destination
    )

    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    Get-ChildItem -LiteralPath $Source -Force |
        Copy-Item -Destination $Destination -Recurse -Force
}

try {
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null
    Write-Host "Downloading the latest HSC Markers release..."
    Invoke-WebRequest -Uri $archiveUrl -OutFile $archivePath
    Expand-Archive -LiteralPath $archivePath -DestinationPath $extractPath

    $repositoryRoot = Get-ChildItem -LiteralPath $extractPath -Directory |
        Select-Object -First 1 -ExpandProperty FullName
    if (-not $repositoryRoot) {
        throw 'The downloaded repository archive was empty.'
    }

    Copy-Tree -Source (Join-Path $repositoryRoot 'skills\mark-hsc-biology') -Destination $skillDestination
    Copy-Tree -Source (Join-Path $repositoryRoot 'sources\biology') -Destination $sourceDestination
} finally {
    $resolvedTempRoot = [IO.Path]::GetFullPath($tempRoot)
    if ($resolvedTempRoot.StartsWith($tempBase, [StringComparison]::OrdinalIgnoreCase) -and
        (Test-Path -LiteralPath $resolvedTempRoot)) {
        Remove-Item -LiteralPath $resolvedTempRoot -Recurse -Force
    }
}

Write-Host "Installed mark-hsc-biology for $Target at $skillDestination"
if ($Target -eq 'Codex') {
    Write-Host 'Restart Codex, then invoke $mark-hsc-biology.'
} else {
    Write-Host 'Restart Claude Code if needed, then invoke /mark-hsc-biology.'
}
