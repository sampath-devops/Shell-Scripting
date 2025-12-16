Application Service & Log Monitoring Script

📌 Overview
In day-to-day operations, continuously monitoring application services and logs is critical to prevent unexpected outages and to proactively identify issues before they impact users.

This Shell Monitoring Script runs at regular intervals and helps DevOps / SRE / Support engineers quickly detect service failures and critical log errors.

🚀 Features

This script runs every 5 minutes and performs the following checks:

✅ Application Service Health Check

🚨 Service Down Alert

🔍 Detects HTTP 500 Errors in the last 10 lines of application logs

⚠️ Identifies Critical Errors in application logs

🛠️ How It Works

Verifies whether the configured application services are running
Scans recent log entries for:

HTTP 500 errors

Critical or fatal error patterns

Displays alert messages when issues are detected

Produes clean, readable console output for easy troubleshooting

📊 Sample Output

✔️ When Services Are Running Normally

![Log Monitoring](image.png)

❌ When a Service Is Down

![service check](image-1.png)

⏱️ Automation with Cron

You can automate this script using a cron job to run every 5 minutes:

*/5 * * * * /path/to/your/script.sh

⚙️ Customization

This script is fully customizable based on your application needs:

Add or remove services to monitor

Update log file paths

Modify error patterns (500, CRITICAL, ERROR, FATAL, etc.)

Integrate email, Slack, or webhook alerts

🎯 Use Cases

Production & non-production monitoring

DevOps / SRE practice projects

Application Support automation 

Proactive incident prevention

📌 Prerequisites

Linux / Unix-based system

Bash shell

Read access to application log files

Permission to check service status

📎 Notes

Ensure log file paths and service names are correctly configured

Test the script manually before enabling cron

Recommended to enable logging within the script for audit and troubleshooting
