Here’s a **clean, production-quality `README.md`** you can directly use for your GitHub repo. It’s written like a real open-source project with clear structure, docs, and safe disclaimers.

***

# 🚀 AI Pro Performance + Stealth + VPN Engine (Windows)

A **PowerShell-based intelligent system optimizer** designed for high-performance laptops (like HP Victus, Ryzen + NVIDIA setups), combining:

* ⚡ Dynamic system performance tuning
* 🔐 Smart VPN automation (Proton VPN)
* 🧠 Memory & CPU optimization
* 🌐 Network-aware DNS + privacy adjustments
* 🤖 Fully automated background execution

> Built for power users, developers, RPA engineers, and long-session workloads.

***

# 🎯 Features

## ⚡ Performance Optimization Engine

* Auto-switches between:
  * 🔥 **Turbo Mode** (high CPU load)
  * ⚡ **Work Mode** (balanced efficiency)
* Intelligent workload detection (RPA, VS Code, Chrome, etc.)
* Process priority boosting
* Smart RAM cleanup (only when needed)

***

## 🔐 VPN Integration (Proton VPN)

* Automatically connects on **Public networks**
* Verifies connection health before trusting it
* Logs connection failures and retries
* Never blocks internet if VPN fails (safe behavior)

***

## 🌐 Smart Network Awareness

* Detects:
  * Public / Private / Unknown networks
* Applies:
  * Secure DNS (Cloudflare)
  * VPN connection only when needed

***

## 🧠 Stability First Design (v3)

* No aggressive firewall blocking
* No risky IPv6 disable
* No kill-switch deadlocks
* Auto-recovery if VPN fails
* Designed for long sessions (10–15 hrs/day usage)

***

## 📊 Logging System

Logs are automatically created:

| File                  | Purpose           |
| --------------------- | ----------------- |
| `performance_log.txt` | CPU/RAM decisions |
| `vpn_log.txt`         | VPN activity      |

Location:

```
C:\Users\<your-user>\
```

***

# 🛠 Requirements

* Windows 10/11
* PowerShell 5.1+
* Administrator privileges
* Proton VPN installed and logged in

***

# 🚀 Installation

## 1. Clone / Copy Script

Place script in:

```
C:\Scripts\ai_pro.ps1
```

***

## 2. Run Once (Manual Test)

```powershell
powershell -ExecutionPolicy Bypass -File C:\Scripts\ai_pro.ps1
```

***

## 3. Run Automatically (Hidden)

Run as Administrator:

```powershell
schtasks /create /tn "AI_Performance_Engine_V3" /tr "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Scripts\ai_pro.ps1" /sc onlogon /rl highest /f
```

✅ Script will:

* Start on login
* Run silently in background
* Optimize continuously

***

# ⏹ Stopping the Script

## ✅ Recommended (Safe Stop)

Create stop file:

```powershell
New-Item "$env:USERPROFILE\stop_ai_engine.txt"
```

✅ Script exits gracefully within \~10 seconds

***

## ❌ Force Stop (if needed)

```powershell
Get-CimInstance Win32_Process | Where-Object {
    $_.CommandLine -like "*ai_pro.ps1*"
} | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
```

***

# ⚙️ Configuration

You can tweak values in the script:

```powershell
$CPU_HIGH = 70
$CPU_LOW  = 25
$RAM_MIN_MB = 4000
```

***

# 🔧 How It Works

## AI Engine Loop

Runs every \~12 seconds:

1. Reads:
   * CPU usage
   * Available RAM
   * Active processes
   * Network type

2. Decision logic:
   * High load → Turbo Mode
   * Low load → Work Mode
   * Low RAM → cleanup
   * Public network → connect VPN

***

## VPN Logic

```
If Public Network:
    Try connect VPN
    Wait + verify
    If success → continue
    If fail → DO NOT block internet
```

✅ Safe fallback behavior

***

# 🔒 Security & Privacy

### ✅ What this improves

* Reduces DNS-based tracking (when on public network)
* Encourages VPN usage in unsafe environments
* Avoids accidental traffic exposure

***

### ⚠️ What this DOES NOT do

* ❌ Full anonymity
* ❌ IP masking without VPN
* ❌ Replace Tor/VPN privacy setups

***

# 🧪 Tested On

* ✅ HP Victus (Ryzen 9 / NVIDIA GPU / 32GB RAM)
* ✅ Windows 11
* ✅ Long sessions (10–15 hours/day)
* ✅ Development + RPA workloads

***

# ⚠️ Safety Notes

* Designed to **never break internet connectivity**
* Does NOT:
  * Force firewall blocking
  * Disable critical network components
* Uses **safe, reversible system tweaks**

***

# 💡 Recommended Setup

### Proton VPN Settings:

* Protocol: **WireGuard**
* Enable:
  * ✅ Auto-reconnect
  * ✅ Built-in Kill Switch (optional)

***

# 🚀 Future Improvements (Roadmap)

* 📊 Live dashboard UI
* 🎮 GPU usage-based tuning
* 🔔 Notifications for network/VPN events
* 🌍 Auto fastest VPN server selection
* 🎛 Tray control application

***

# 🤝 Contributing

Feel free to fork, improve, and submit PRs.

Suggestions welcome for:

* Performance enhancements
* Additional hardware profiles
* Safer VPN integrations

***

# 📄 License

MIT License (recommended)

***

# 🙌 Acknowledgements

Inspired by:

* Windows power users
* RPA automation needs
* High-performance workstation tuning practices

***

# ⭐ If this helped you

Give it a ⭐ on GitHub — helps others discover it!


