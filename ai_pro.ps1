Write-Host "=== AI PRO ENGINE v3 (STABLE) ===" -ForegroundColor Cyan

# -------------------------------
# CONFIG
# -------------------------------
$CPU_HIGH = 70
$CPU_LOW  = 25
$RAM_MIN_MB = 4000

$perfLog = "$env:USERPROFILE\performance_log.txt"
$vpnLog  = "$env:USERPROFILE\vpn_log.txt"

$mode = "Work"

$ultimate = "e9a42b02-d5df-448d-aa00-03f14749eb61"

# Ensure power plan exists
if (-not (powercfg -list | Select-String $ultimate)) {
    powercfg -duplicatescheme $ultimate | Out-Null
}

# -------------------------------
# ADAPTER
# -------------------------------
function Get-ActiveAdapter {
    Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1
}

# -------------------------------
# PERFORMANCE
# -------------------------------
function Set-Turbo {
    powercfg -setactive $ultimate
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100
    Write-Host "🔥 TURBO MODE"
}

function Set-Work {
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 5
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 85
    Write-Host "⚡ WORK MODE"
}

function Boost-Apps {
    $apps = @("chrome","msedge","Code","UiPath","mstsc","devenv")
    foreach ($a in $apps) {
        Get-Process -Name $a -ErrorAction SilentlyContinue | ForEach-Object {
            try { $_.PriorityClass = "High" } catch {}
        }
    }
}

function Detect-HeavyWorkload {
    $top = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
    foreach ($p in $top) {
        if ($p.ProcessName -match "chrome|msedge|Code|UiPath|mstsc|devenv") {
            return $true
        }
    }
    return $false
}

function Clean-RAM {
    [System.GC]::Collect()
    Write-Host "🧠 RAM optimized"
}

# -------------------------------
# VPN FUNCTIONS (SAFE)
# -------------------------------

function Is-VPNConnected {
    Get-NetAdapter | Where-Object {
        $_.InterfaceDescription -match "Proton|VPN|WireGuard" -and $_.Status -eq "Up"
    }
}

function Connect-ProtonVPN {
    Write-Host "🔐 Connecting Proton VPN..."

    Start-Process "protonvpn://connect" -ErrorAction SilentlyContinue

    Start-Sleep -Seconds 8   # wait for connection

    if (Is-VPNConnected) {
        Write-Host "✅ VPN Connected"
        "VPN Connected $(Get-Date)" >> $vpnLog
        return $true
    } else {
        Write-Host "⚠️ VPN connection failed"
        "VPN FAILED $(Get-Date)" >> $vpnLog
        return $false
    }
}

# -------------------------------
# NETWORK TYPE
# -------------------------------
function Get-NetworkType {
    try { (Get-NetConnectionProfile).NetworkCategory }
    catch { "Unknown" }
}

# -------------------------------
# DNS STEALTH (SAFE)
# -------------------------------
function Apply-SafeDNS($adapterName) {
    try {
        Set-DnsClientServerAddress -InterfaceAlias $adapterName `
            -ServerAddresses ("1.1.1.1","1.0.0.1")
        Clear-DnsClientCache
        Write-Host "🌐 Secure DNS applied"
    } catch {}
}

# -------------------------------
# LOG
# -------------------------------
function Log-Perf($cpu,$ram,$mode) {
    "$((Get-Date)) CPU:$cpu RAM:$ram MODE:$mode" >> $perfLog
}

# -------------------------------
# MAIN LOOP
# -------------------------------

while ($true) {

    Start-Sleep -Seconds 12

    try {
        $adapter = Get-ActiveAdapter
        if (-not $adapter) { continue }

        # CPU
        $cpuVal = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
        $cpu = [math]::Round($cpuVal)

        # RAM
        $os = Get-CimInstance Win32_OperatingSystem
        $freeMB = [math]::Round($os.FreePhysicalMemory / 1024)

        $heavy = Detect-HeavyWorkload
        $netType = Get-NetworkType
        $vpnConnected = Is-VPNConnected

        Write-Host "CPU:$cpu RAM:$freeMB MODE:$mode NET:$netType VPN:$($vpnConnected -ne $null)"

        # -----------------------
        # PERFORMANCE AI
        # -----------------------
        if (($cpu -gt $CPU_HIGH -or $heavy) -and $mode -ne "Turbo") {
            Set-Turbo
            $mode = "Turbo"
        }
        elseif ($cpu -lt $CPU_LOW -and -not $heavy -and $mode -ne "Work") {
            Set-Work
            $mode = "Work"
        }

        if ($freeMB -lt $RAM_MIN_MB) {
            Clean-RAM
        }

        Boost-Apps

        # -----------------------
        # SAFE STEALTH + VPN
        # -----------------------

        if ($netType -eq "Public") {

            # Apply safe DNS
            Apply-SafeDNS $adapter.Name

            # Connect VPN only if needed
            if (-not $vpnConnected) {

                $connected = Connect-ProtonVPN

                if (-not $connected) {
                    Write-Host "⚠️ VPN not available — continuing without blocking internet"
                }
            }
        }

        # -----------------------
        # LOGGING
        # -----------------------
        Log-Perf $cpu $freeMB $mode

    } catch {
        Write-Host "Minor error handled..."
    }
}