# Copilot / AI Agent Instructions for this repository

Purpose: concise, executable guidance so an AI coding assistant can be immediately productive working on these shell-script exercises.

- **Big picture:** This repository contains small shell-script projects (learning exercises) under `Beginner/`. Key scripts:
  - `Beginner/Project 1/System_monitor.sh` — collects CPU, memory, disk using `top`, `free`, `df` and prints percentage metrics.
  - `Beginner/Project 1/System_monitor_while_Condition.sh` — same as above but runs continuously in a `while true` loop and refreshes every 2s.
  - `Beginner/Project 2/Application_log_monitor.sh` — currently a placeholder (shebang only).

- **Why things are structured this way:** files are standalone, single-purpose shell scripts meant to be runnable examples. There is no build system, package manager, or tests — edits should preserve simple CLI usage and shell compatibility.

- **Runtime / environment expectations:**
  - Scripts target `bash` (shebang `#!/bin/bash`) and use Bash-specific features (`(( ))` arithmetic, `[[`/`]]`-style tests). Always run with `bash`, not `/bin/sh`.
  - They rely on standard GNU userland tools: `top`, `free`, `df`, `awk`, `tput`, `grep`, `tail`. On Windows, use WSL, Git Bash, or a Linux VM to run and test.

- **Common patterns to follow (copy these examples):**
  - Threshold variables in UPPER_SNAKE_CASE, e.g. `CPU_THRESHOLD=80`.
  - Metric collection -> normalize (strip decimals) -> numeric compare -> `send_alert()`:
    - Example (CPU): `cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 +$4}')` then `cpu_usage=${cpu_usage%.*}` then `if ((cpu_usage >= CPU_THRESHOLD)); then send_alert "CPU" "$cpu_usage"; fi`.
  - `send_alert()` uses `tput` to colorize output. Preserve this approach when adding alerts or log messages.

- **Files that show important patterns:**
  - `Beginner/Project 1/System_monitor.sh` — single-shot metric gather + alert logic.
  - `Beginner/Project 1/System_monitor_while_Condition.sh` — same logic inside an infinite loop; refresh interval set with `sleep 2`.

- **Developer workflows / useful commands:**
  - Run a script once: `bash "Beginner/Project 1/System_monitor.sh"` or make executable `chmod +x "Beginner/Project 1/System_monitor.sh"` then `./Beginner/Project 1/System_monitor.sh`.
  - Run continuously: `bash "Beginner/Project 1/System_monitor_while_Condition.sh"` (stop with Ctrl-C).
  - Debug with shell tracing: `bash -x "Beginner/Project 1/System_monitor.sh"` to see expanded commands.
  - On Windows, run under WSL: `wsl bash "Beginner/Project 1/System_monitor.sh"`.

- **What to expect when editing:**
  - Keep scripts minimal and self-contained. Avoid introducing external dependencies unless adding a clear README and install instructions.
  - Preserve explicit `#!/bin/bash` shebang and Bash-specific idioms.
  - If you modify `Application_log_monitor.sh`, document expected log path and examples (e.g., `tail -F /var/log/app.log | grep --line-buffered "ERROR"`).

- **Testing changes:**
  - Manual run is the primary test. Verify output on a Linux environment and test Ctrl-C behavior for looping scripts.
  - Use `bash -n` for a quick syntax check: `bash -n path/to/script.sh`.

- **Repository conventions & quick notes for AI agents:**
  - No unit tests or CI present — propose changes conservatively and include runnable examples in the updated script's header or README when adding features.
  - Author metadata appears in headers (e.g., `#AUTHOR: Sampath`) — do not remove unless intentionally normalizing headers across the repo.
  - Keep colorized alert printing via `tput` for visibility in terminal output.

- If anything above is unclear (expected log locations for `Application_log_monitor.sh`, target platform for CI, or preferred behavior for alerts), ask the maintainer before adding external packages or tests.

---
Please review — I can iterate on wording, add concrete `tail`/`grep` examples for `Application_log_monitor.sh`, or scaffold a small README for Project 2.
