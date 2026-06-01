Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$assetDir = Join-Path $root "assets"
New-Item -ItemType Directory -Force -Path $assetDir | Out-Null

$width = 1800
$height = 1100
$bitmap = New-Object System.Drawing.Bitmap $width, $height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

function New-Color($hex) {
  return [System.Drawing.ColorTranslator]::FromHtml($hex)
}

function Fill-RoundRect($graphics, $brush, [float]$x, [float]$y, [float]$w, [float]$h, [float]$r) {
  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $diameter = $r * 2
  $path.AddArc($x, $y, $diameter, $diameter, 180, 90)
  $path.AddArc($x + $w - $diameter, $y, $diameter, $diameter, 270, 90)
  $path.AddArc($x + $w - $diameter, $y + $h - $diameter, $diameter, $diameter, 0, 90)
  $path.AddArc($x, $y + $h - $diameter, $diameter, $diameter, 90, 90)
  $path.CloseFigure()
  $graphics.FillPath($brush, $path)
  $path.Dispose()
}

function Draw-Label($graphics, $text, [float]$x, [float]$y, [float]$size, $color, [string]$style = "Regular") {
  $fontStyle = [System.Drawing.FontStyle]::$style
  $font = New-Object System.Drawing.Font("Microsoft YaHei", $size, $fontStyle, [System.Drawing.GraphicsUnit]::Pixel)
  $brush = New-Object System.Drawing.SolidBrush $color
  $graphics.DrawString($text, $font, $brush, $x, $y)
  $brush.Dispose()
  $font.Dispose()
}

$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
  (New-Object System.Drawing.Rectangle 0, 0, $width, $height),
  (New-Color "#eef2f4"),
  (New-Color "#cfd8df"),
  20
)
$graphics.FillRectangle($bgBrush, 0, 0, $width, $height)
$bgBrush.Dispose()

$softWhite = New-Object System.Drawing.SolidBrush (New-Color "#fbfcfd")
$ink = New-Color "#17202a"
$muted = New-Color "#687580"
$red = New-Color "#c9362c"
$green = New-Color "#177c68"
$gold = New-Color "#9b6a19"
$linePen = New-Object System.Drawing.Pen (New-Color "#d8e0e6"), 2

Fill-RoundRect $graphics $softWhite 170 130 1460 800 26
$graphics.DrawRectangle($linePen, 205, 188, 1390, 672)

$navBrush = New-Object System.Drawing.SolidBrush (New-Color "#101820")
Fill-RoundRect $graphics $navBrush 210 190 250 668 16
Draw-Label $graphics "Polaris" 258 238 34 (New-Color "#ffffff") "Bold"
Draw-Label $graphics "Product Workbench" 258 286 20 (New-Color "#aeb8c2")

$menuItems = @("CRM", "ERP Orders", "Inventory", "Device Data", "Analytics")
for ($i = 0; $i -lt $menuItems.Length; $i++) {
  $y = 365 + ($i * 72)
  $itemBrush = New-Object System.Drawing.SolidBrush $(if ($i -eq 1) { New-Color "#c9362c" } else { New-Color "#22303b" })
  Fill-RoundRect $graphics $itemBrush 248 $y 174 44 8
  Draw-Label $graphics $menuItems[$i] 276 ($y + 9) 18 (New-Color "#ffffff") "Bold"
  $itemBrush.Dispose()
}

Draw-Label $graphics "Business Overview" 520 230 42 $ink "Bold"
Draw-Label $graphics "Customer, order, stock, device and finance data" 522 286 22 $muted

$cards = @(
  @{ X = 520; Y = 345; W = 250; H = 150; T = "Sales Leads"; V = "1,286"; C = $red },
  @{ X = 800; Y = 345; W = 250; H = 150; T = "Active Orders"; V = "342"; C = $green },
  @{ X = 1080; Y = 345; W = 250; H = 150; T = "Stock Alerts"; V = "27"; C = $gold }
)

foreach ($card in $cards) {
  $cardBrush = New-Object System.Drawing.SolidBrush (New-Color "#ffffff")
  Fill-RoundRect $graphics $cardBrush $card.X $card.Y $card.W $card.H 12
  Draw-Label $graphics $card.T ($card.X + 24) ($card.Y + 24) 20 $muted
  Draw-Label $graphics $card.V ($card.X + 24) ($card.Y + 64) 42 $ink "Bold"
  $accentBrush = New-Object System.Drawing.SolidBrush $card.C
  Fill-RoundRect $graphics $accentBrush ($card.X + 186) ($card.Y + 30) 38 88 8
  $accentBrush.Dispose()
  $cardBrush.Dispose()
}

$chartBrush = New-Object System.Drawing.SolidBrush (New-Color "#ffffff")
Fill-RoundRect $graphics $chartBrush 520 540 520 270 12
Draw-Label $graphics "Pipeline and Payment Trend" 548 568 22 $ink "Bold"
for ($i = 0; $i -lt 6; $i++) {
  $x = 560 + ($i * 72)
  $barHeight = @(92, 132, 108, 158, 126, 178)[$i]
  $barBrush = New-Object System.Drawing.SolidBrush $(if ($i % 2 -eq 0) { $red } else { $green })
  Fill-RoundRect $graphics $barBrush $x (760 - $barHeight) 34 $barHeight 6
  $barBrush.Dispose()
}

Fill-RoundRect $graphics $chartBrush 1080 540 360 270 12
Draw-Label $graphics "Device Online Status" 1108 568 22 $ink "Bold"
$status = @(
  @{ T = "Gateway A12"; V = "Online"; C = $green },
  @{ T = "Line 03"; V = "Collecting"; C = $gold },
  @{ T = "Warehouse"; V = "Online"; C = $green }
)
for ($i = 0; $i -lt $status.Length; $i++) {
  $y = 630 + ($i * 52)
  Draw-Label $graphics $status[$i].T 1110 $y 19 $muted
  $dotBrush = New-Object System.Drawing.SolidBrush $status[$i].C
  Fill-RoundRect $graphics $dotBrush 1336 ($y + 4) 18 18 9
  $dotBrush.Dispose()
  Draw-Label $graphics $status[$i].V 1364 ($y - 1) 18 $ink "Bold"
}

Draw-Label $graphics "CRM" 1410 720 72 (New-Color "#dce3e8") "Bold"
Draw-Label $graphics "ERP" 1260 848 72 (New-Color "#dce3e8") "Bold"
Draw-Label $graphics "IoT" 1440 930 72 (New-Color "#dce3e8") "Bold"

$overlayBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
  (New-Object System.Drawing.Rectangle 0, 0, $width, $height),
  [System.Drawing.Color]::FromArgb(40, 15, 21, 27),
  [System.Drawing.Color]::FromArgb(130, 15, 21, 27),
  0
)
$graphics.FillRectangle($overlayBrush, 0, 0, $width, $height)

$output = Join-Path $assetDir "product-line-workbench.png"
$bitmap.Save($output, [System.Drawing.Imaging.ImageFormat]::Png)

$overlayBrush.Dispose()
$chartBrush.Dispose()
$navBrush.Dispose()
$linePen.Dispose()
$softWhite.Dispose()
$graphics.Dispose()
$bitmap.Dispose()

Write-Host "Generated $output"
