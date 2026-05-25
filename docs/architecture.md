Here is a **professional, production-quality `docs/architecture.md`** for your project. You can drop this directly into your repo.

***

# 🧠 Architecture Overview

## AI Pro Performance + Stealth + VPN Engine

This document describes the internal architecture, components, and decision flow of the **AI Pro Performance Engine** — a lightweight, autonomous PowerShell-based system optimizer and network-aware automation tool for Windows.

***

# 🎯 Design Goals

The system is designed with the following principles:

* ✅ **Stability-first** (never break network connectivity)
* ✅ **Autonomous operation** (no user interaction required)
* ✅ **Context-aware behavior** (reacts to system + network state)
* ✅ **Low overhead** (runs efficiently for long sessions)
* ✅ **Fail-safe design** (recovers from errors gracefully)

***

# 🧩 High-Level Architecture

```
               +------------------------+
               |  Task Scheduler        |
               | (Auto Start at Login)  |
               +-----------+------------+
                           |
                           v
               +------------------------+
               | AI Engine Main Loop    |
               | (Runs every ~12 sec)   |
               +-----------+------------+
                           |
       +-------------------+-------------------+
       |                   |                   |
       v                   v                   v
+------------+      +-------------+      +-------------+
| CPU/RAM    |      | Network     |      | Process     |
| Monitor    |      | Detection   |      | Analyzer    |
+------------+      +-------------+      +-------------+
       |                   |                   |
       |                   |                   |
       v                   v                   v
+------------+      +-------------+      +-------------+
| Perf Engine|      | VPN Engine  |      | App Booster |
+------------+      +-------------+      +-------------+
       |                   |                   |
       +-------------------+-------------------+
                           |
                           v
               +------------------------+
               | Logging Subsystem      |
               +------------------------+
```

***

# 🔄 Execution Flow

The engine operates in a continuous loop (\~12 second interval):

## 1. System State Collection

Each cycle collects:

* CPU usage (`Get-Counter`)
* Available memory (`Win32_OperatingSystem`)
* Top processes (by CPU usage)
* Network type (`Get-NetConnectionProfile`)
* VPN adapter status

***

## 2. Decision Engine

Based on collected data, the system makes intelligent decisions:

### CPU-Based Mode Switching

| Condition                         | Action                  |
| --------------------------------- | ----------------------- |
| CPU > threshold OR heavy workload | Enable **Turbo Mode**   |
| CPU < threshold AND idle workload | Switch to **Work Mode** |

***

### RAM Management

| Condition                | Action                     |
| ------------------------ | -------------------------- |
| Free RAM below threshold | Trigger garbage collection |

***

### Workload Detection

The system detects heavy workloads based on top processes:

* Browsers (Chrome, Edge)
* Development tools (VS Code, Visual Studio)
* RPA tools (UiPath)
* Remote desktop sessions (mstsc)

***

## 3. Action Execution Layer

### ⚡ Performance Engine

Controls power plan behavior:

* **Turbo Mode**
  * Maximum CPU performance
  * High responsiveness
* **Work Mode**
  * Balanced efficiency
  * Reduced thermals

***

### 🔐 VPN Engine (Proton VPN Integration)

On detecting a **Public network**:

```
IF VPN not connected:
    → Trigger VPN connection
    → Wait for connection (~8 sec)
    → Verify connection state
    → Continue whether success or fail (fail-safe)
```

Key design:

* ✅ No forced blocking
* ✅ No dependency on VPN success
* ✅ Safe fallback (internet remains usable)

***

### 🌐 Network Optimization

* Applies **secure DNS (Cloudflare)**
* Avoids disabling critical protocols (IPv6)
* Keeps system connectivity intact

***

### 🎯 Process Optimization

* Boosts priority of:
  * Browsers
  * Development tools
  * RPA engines
  * Remote desktop sessions

***

## 4. Logging Subsystem

Logs are written asynchronously to avoid performance impact.

### 📄 Files

| File                  | Purpose                         |
| --------------------- | ------------------------------- |
| `performance_log.txt` | CPU, RAM, system mode decisions |
| `vpn_log.txt`         | VPN connect / fail events       |

### Example Entry

```
2026-05-25 10:12:01 CPU:78 RAM:10240 MODE:Turbo
2026-05-25 10:12:05 VPN Connected
```

***

# 🔁 Fault Tolerance & Recovery

The engine is designed to **never crash or disrupt system usability**.

## ✅ Error Handling

* All major blocks wrapped in `try/catch`
* Failures do not interrupt loop execution

***

## ✅ Network Safety

Unlike earlier versions:

* ❌ No aggressive firewall rules
* ❌ No kill-switch blocking internet
* ❌ No forced protocol disabling

***

## ✅ VPN Fail-Safe

If VPN connection fails:

* ✅ Script logs failure
* ✅ Internet continues working
* ✅ No retry flooding

***

# 🧠 Performance Considerations

The system is optimized for long-running sessions:

* Low CPU overhead (\~0–1% idle)
* Minimal memory usage
* Efficient polling interval (12 sec)
* Selective processing (top processes only)

***

# 🔐 Security Model

## ✅ What is enforced

* VPN usage on public networks
* Secure DNS application
* Reduced exposure on unsafe networks

***

## ⚠️ What is NOT enforced

* Full anonymity
* Traffic encryption without VPN
* Deep packet filtering

***

# 🔌 Integration Points

## Task Scheduler

Provides:

* Auto-start at login
* Hidden execution
* Elevated privileges

***

## Proton VPN

Uses:

* URI-based connection (`protonvpn://connect`)
* Adapter detection (WireGuard / TAP)

***

# 🧪 Known Constraints

| Area              | Limitation                          |
| ----------------- | ----------------------------------- |
| VPN detection     | Depends on adapter naming           |
| Proton URI        | May vary by version                 |
| Network detection | Depends on Windows profile accuracy |

***

# 🚀 Future Architecture Enhancements

Planned improvements:

* 📊 Real-time dashboard UI
* 🎮 GPU utilization integration
* 🌍 Smart VPN server selection
* 🔔 Event notification system
* ⚙️ Modular plugin system
* 🧩 Multi-profile configuration (Work/Gaming/Stealth)

***

# 📌 Summary

The AI Pro Engine is a:

✅ Lightweight autonomous system tuner  
✅ Context-aware network intelligence layer  
✅ Safe VPN automation controller  
✅ Long-running performance optimizer

It balances:

* ⚡ **Performance**
* 🔐 **Privacy**
* 🧠 **Stability**

***

# 🙌 Contribution Notes

When modifying the architecture:

* Preserve fail-safe behavior
* Avoid aggressive system-level changes
* Maintain modular function structure
* Ensure compatibility with standard Windows environments

***

