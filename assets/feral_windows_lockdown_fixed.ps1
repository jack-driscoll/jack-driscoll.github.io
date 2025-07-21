param(
    [switch]$Revert
)

function Set-NCSI {
    $key = "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet"
    if (!(Test-Path $key)) {
        New-Item -Path $key -Force | Out-Null
    }
    if ($Revert) {
        Write-Host "Re-enabling NCSI active probing..." -ForegroundColor Cyan
        Remove-ItemProperty -Path $key -Name "EnableActiveProbing" -ErrorAction SilentlyContinue
    } else {
        Write-Host "Disabling NCSI active probing..." -ForegroundColor Cyan
        Set-ItemProperty -Path $key -Name "EnableActiveProbing" -Value 0 -Type DWord
    }
}

function Lock-TelemetryBinary {
    param([string]$Path)
    if (Test-Path $Path) {
        if ($Revert) {
            Write-Host "Restoring: $Path"
            icacls $Path /remove:d Everyone
        } else {
            takeown /f $Path | Out-Null
            icacls $Path /grant administrators:F | Out-Null
            icacls $Path /deny Everyone:RX | Out-Null
            Write-Host "Blocked execution: $Path"
        }
    } else {
        Write-Host "Not found: $Path"
    }
}

Write-Host ($Revert ? "Reverting lockdown..." : "Applying lockdown...") -ForegroundColor Yellow

# DiagTrack / Telemetry services
if ($Revert) {
    Set-Service DiagTrack -StartupType Manual -ErrorAction SilentlyContinue
    Start-Service DiagTrack -ErrorAction SilentlyContinue
} else {
    Stop-Service DiagTrack -Force -ErrorAction SilentlyContinue
    Set-Service DiagTrack -StartupType Disabled
}

# CompatTel scheduled task
if ($Revert) {
    Enable-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" -TaskName "Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue
} else {
    Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" -TaskName "Microsoft Compatibility Appraiser" -ErrorAction SilentlyContinue
}

# Appraiser registry tweak
$regKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser"
if (!(Test-Path $regKey)) {
    New-Item -Path $regKey -Force | Out-Null
}
if ($Revert) {
    Remove-ItemProperty -Path $regKey -Name "DisableInventory" -ErrorAction SilentlyContinue
} else {
    Set-ItemProperty -Path $regKey -Name "DisableInventory" -Value 1 -Type DWord
}

# Lock or unlock binary execution
Lock-TelemetryBinary "$env:windir\System32\CompatTelRunner.exe"
Lock-TelemetryBinary "$env:windir\System32\OneSettingsClientHost.exe"

# NCSI edit
Set-NCSI

Write-Host ($Revert ? "Lockdown reverted. System is back to default." : "Lockdown complete. You are now mostly feral.") -ForegroundColor Green
