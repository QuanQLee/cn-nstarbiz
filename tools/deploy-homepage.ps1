param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^site-[0-9]{8}-homepage-r[0-9]+$')]
    [string]$ReleaseId
)

$ErrorActionPreference = 'Stop'
$workspace = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$artifactDirectory = Join-Path $workspace "artifacts/$ReleaseId"
New-Item -ItemType Directory -Path $artifactDirectory -Force | Out-Null
$archiveName = "$ReleaseId.tar.gz"
$archive = Join-Path $artifactDirectory $archiveName
$sshHost = 'ubuntu@122.51.98.219'
$sshOptions = @('-o', 'BatchMode=yes', '-o', 'ConnectTimeout=15', '-o', 'StrictHostKeyChecking=yes')
$publicFiles = @(
    'index.html', 'home.css', 'home.js', 'privacy.html', 'styles.css', 'main.js',
    'robots.txt', 'sitemap.xml', 'baidu_verify_codeva-E9ctYFl28H.html', 'assets'
)

foreach ($file in $publicFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $workspace $file))) {
        throw "Missing release file: $file"
    }
}
& tar -czf $archive -C $workspace -- @publicFiles
if ($LASTEXITCODE -ne 0) { throw 'Could not create the release archive.' }
$entries = & tar -tzf $archive
if ($LASTEXITCODE -ne 0) { throw 'Could not inspect the release archive.' }
foreach ($entry in $entries) {
    $normalized = $entry -replace '^\./', ''
    if ($normalized -match '(^|/)\.\.(/|$)' -or $normalized.StartsWith('/')) {
        throw "Unsafe archive entry: $entry"
    }
    if (-not ($normalized -match '^assets(/|$)' -or $normalized -in $publicFiles)) {
        throw "Unexpected archive entry: $entry"
    }
}
$archiveHash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLowerInvariant()
$indexHash = (Get-FileHash -LiteralPath (Join-Path $workspace 'index.html') -Algorithm SHA256).Hash.ToLowerInvariant()

& scp @sshOptions $archive "${sshHost}:/tmp/$archiveName"
if ($LASTEXITCODE -ne 0) { throw 'Release upload failed.' }

$remoteScript = @'
set -euo pipefail
release_id="$1"
archive_hash="$2"
index_hash="$3"
base=/opt/nstarbiz-site
archive="/tmp/$release_id.tar.gz"
release="$base/releases/$release_id"
backup="$base/backups/$release_id-previous.tar.gz"
link="$base/.current-$release_id"

[[ "$release_id" =~ ^site-[0-9]{8}-homepage-r[0-9]+$ ]] || exit 2
old=$(readlink -f "$base/current")
[[ "$old" == "$base/releases/"* && -d "$old" ]] || { echo 'Unexpected current root'; exit 2; }
[[ "$release" == "$base/releases/"* && ! -e "$release" && ! -L "$release" ]] || { echo 'Release already exists'; exit 2; }
[[ ! -e "$link" && ! -L "$link" && ! -e "$backup" ]] || { echo 'Release artifacts already exist'; exit 2; }
printf '%s  %s\n' "$archive_hash" "$archive" | sha256sum --check --status
sudo -n nginx -t

umask 077
install -d -m 700 "$base/backups"
tar -czf "$backup" -C "$old" .
test -s "$backup"
umask 022
install -d -m 755 "$release"
cp -a "$old/." "$release/"
tar --no-same-owner --no-same-permissions -xzf "$archive" -C "$release"
find "$release" -type d -exec chmod 755 {} +
find "$release" -type f -exec chmod 644 {} +
printf '%s  %s\n' "$index_hash" "$release/index.html" | sha256sum --check --status
cmp "$old/baidu_verify_codeva-E9ctYFl28H.html" "$release/baidu_verify_codeva-E9ctYFl28H.html"
test -s "$release/home.css"
test -s "$release/home.js"

ln -s "$release" "$link"
mv -Tf "$link" "$base/current"
printf 'RELEASE=%s\nPREVIOUS=%s\nBACKUP=%s\nINDEX_SHA256=%s\n' "$release" "$old" "$backup" "$index_hash"
'@

$output = $remoteScript.Replace("`r`n", "`n") | & ssh @sshOptions $sshHost "bash -s -- '$ReleaseId' '$archiveHash' '$indexHash'"
if ($LASTEXITCODE -ne 0) { throw 'Remote release failed. Inspect the previous release before retrying.' }
$output | Tee-Object -FilePath (Join-Path $artifactDirectory 'remote-release.txt')
[ordered]@{
    release = $ReleaseId
    archive = $archiveName
    archiveSha256 = $archiveHash
    indexSha256 = $indexHash
    files = $publicFiles
    crmIncluded = $false
    nginxChanged = $false
} | ConvertTo-Json -Depth 3 | Set-Content -LiteralPath (Join-Path $artifactDirectory 'manifest.json') -Encoding utf8
