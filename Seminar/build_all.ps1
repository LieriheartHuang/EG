$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$folders = Get-ChildItem -LiteralPath $root -Directory | Where-Object {
  Test-Path -LiteralPath (Join-Path $_.FullName 'main.tex')
}
foreach ($folder in $folders) {
  Push-Location $folder.FullName
  try {
    pdflatex -interaction=nonstopmode main.tex
  } finally {
    Pop-Location
  }
}