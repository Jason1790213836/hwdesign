# Get the current directory
$projectDir = Get-Location

# Create overlay directory
$overlayDir = Join-Path $projectDir "overlay"
New-Item -ItemType Directory -Force -Path $overlayDir | Out-Null

# Find the latest .bit file containing "impl_1"
$bitfile = Get-ChildItem -Path $projectDir -Recurse -Filter "*.bit" |
    Where-Object { $_.FullName -match "impl_1" } |
    Sort-Object LastWriteTime |
    Select-Object -Last 1

if (-not $bitfile) {
    Write-Host "❌ No .bit file found in $projectDir. Make sure synthesis and implementation are complete."
    exit 1
}

# Derive base name from .bit file
$bitbase = $bitfile.BaseName -replace "_wrapper$", ""

# Find corresponding .hwh file
$hwhfile = Get-ChildItem -Path $projectDir -Recurse -Filter "$bitbase.hwh" | Select-Object -First 1

if (-not $hwhfile) {
    Write-Host "❌ No .hwh file found in $projectDir. Make sure synthesis and implementation are complete."
    exit 1
}

# Find .tcl file in same directory as .bit
$bitdir = $bitfile.DirectoryName
$tclfile = Get-ChildItem -Path $bitdir -Filter "*.tcl" | Select-Object -First 1

if (-not $tclfile) {
    Write-Host "❌ No .tcl file found in $bitdir. Make sure synthesis and implementation are complete."
    exit 1
}

# Derive base name from project folder
$base = Split-Path $projectDir -Leaf

# Copy and rename
Copy-Item $bitfile.FullName -Destination "$overlayDir\$base.bit"
Copy-Item $hwhfile.FullName -Destination "$overlayDir\$base.hwh"
Copy-Item $tclfile.FullName -Destination "$overlayDir\$base.tcl"

# Print file info
Write-Host "Source file info:"
foreach ($f in @($bitfile, $hwhfile, $tclfile)) {
    Write-Host "  $($f.FullName)"
    Write-Host "    Last modified: $($f.LastWriteTime)"
}

Write-Host "Overlay files copied to: $overlayDir"
Write-Host "  $base.bit"
Write-Host "  $base.hwh"
Write-Host "  $base.tcl"