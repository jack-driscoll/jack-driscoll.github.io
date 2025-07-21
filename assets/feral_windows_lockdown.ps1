# Feral Windows Lockdown Script
# Disables telemetry, blocks OneSettings, CompatTel, and MS phone-home endpoints

Write-Host "Disable Bing and Search to Use Location"
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "AllowSearchToUseLocation" -Value 0 -PropertyType DWord -Force

Write-Host "Block Windows Telemetry Domains"

$telemetryDomains = @(
  "vortex.data.microsoft.com",
  "settings-win.data.microsoft.com",
  "telemetry.microsoft.com",
  "watson.telemetry.microsoft.com",
  "oca.telemetry.microsoft.com",
  "sqm.microsoft.com",
  "wdcp.microsoft.com",
  "tsfe.trafficshaping.dsp.mp.microsoft.com"
)

foreach ($domain in $telemetryDomains) {
    New-NetFirewallRule -DisplayName "Block $domain" `
	-Direction Outbound `
    -RemoteAddress $domain `
    -Action Block `
    -Enabled True `
    -Profile Any
}

Write-Host "Disabling NCSI"
Set-ItemProperty -Path $key -Name "EnableActiveProbing" -Value 0 -Type DWord

Write-Host "Disabling DiagTrack and dmwappushsvc..." -ForegroundColor Cyan
Stop-Service DiagTrack -Force -ErrorAction SilentlyContinue
Set-Service DiagTrack -StartupType Disabled
Stop-Service dmwappushsvc -Force -ErrorAction SilentlyContinue
Set-Service dmwappushsvc -StartupType Disabled

Write-Host "Disabling Compatibility Appraiser task..." -ForegroundColor Cyan
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" -TaskName "Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue

Write-Host "Applying Appraiser inventory registry tweak..." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser" `
    -Name "DisableInventory" -Value 1 -PropertyType DWord -Force | Out-Null

Write-Host "Setting execution deny ACLs on known telemetry binaries..." -ForegroundColor Cyan
$compatTel = "$env:windir\System32\CompatTelRunner.exe"
if (Test-Path $compatTel) {
    Write-Host "Taking ownership of CompatTelRunner.exe..." -ForegroundColor Cyan
    takeown /f $compatTel | Out-Null
    icacls $compatTel /grant administrators:F | Out-Null
    icacls $compatTel /deny Everyone:RX | Out-Null
    Write-Host "Blocked execution: $compatTel" -ForegroundColor Yellow
} else {
    Write-Host "Not found (already gone or not installed): $compatTel"
}
$targets = @(
    "$env:windir\System32\OneSettingsClientHost.exe"
)
foreach ($file in $targets) {
    if (Test-Path $file) {
        icacls $file /deny "Everyone:(RX)" | Out-Null
        Write-Host "Blocked: $file"
    } else {
        Write-Host "Not found: $file"
    }
}

Write-Host "Lockdown complete. Bill isn't going to touch you again (ok, let's be honest he probably will despite your objections)." -ForegroundColor Green
