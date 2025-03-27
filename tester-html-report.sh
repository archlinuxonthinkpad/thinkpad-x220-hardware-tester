#!/bin/bash

# ThinkPad X220 Hardware Information and Status (HTML Report Option)

# Variables to track status
CPU_STATUS="OK"
MEMORY_STATUS="OK"
DISK_STATUS="OK"
WIRELESS_STATUS="OK"
BATTERY_STATUS="OK"
TEMPERATURE_STATUS="OK"
USB_STATUS="OK"
PCI_STATUS="OK"
NETWORK_STATUS="OK"

# HTML Report Option
HTML_REPORT=false

# Function to generate HTML report
generate_html_report() {
  local report_file="x220_report.html"
  echo "Generating HTML report: $report_file"

  cat <<EOF > "$report_file"
<!DOCTYPE html>
<html>
<head>
<title>ThinkPad X220 Hardware Report</title>
<style>
body { font-family: monospace; }
table { border-collapse: collapse; width: 80%; margin: 20px auto; }
th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
th { background-color: #f2f2f2; }
.status-ok { color: green; }
.status-failed { color: red; }
</style>
</head>
<body>
<h1>ThinkPad X220 Hardware Report</h1>

<h2>System Information</h2>
<table>
<tr><th>Item</th><th>Value</th></tr>
<tr><td>Kernel</td><td>$(uname -a)</td></tr>
<tr><td>CPU Model</td><td>$(cat /proc/cpuinfo | grep "model name" | head -n 1)</td></tr>
<tr><td>Memory</td><td>$(free -h | grep Mem)</td></tr>
<tr><td>Disk Space</td><td>$(df -h /dev/sda1 2>/dev/null)</td></tr>
<tr><td>Network</td><td>$(ip a | grep "inet ")</td></tr>
<tr><td>Wireless Interface</td><td>$(iwconfig 2>/dev/null | grep ESSID)</td></tr>
<tr><td>Battery</td><td>$(acpi -b 2>/dev/null)</td></tr>
<tr><td>Temperature</td><td>$(sensors 2>/dev/null | grep Core)</td></tr>
<tr><td>PCI Devices</td><td>$(lspci)</td></tr>
<tr><td>USB Devices</td><td>$(lsusb)</td></tr>
</table>

<h2>Hardware Status</h2>
<table>
<tr><th>Component</th><th>Status</th></tr>
<tr><td>CPU</td><td class="status-$([[ "$CPU_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$CPU_STATUS</td></tr>
<tr><td>Memory</td><td class="status-$([[ "$MEMORY_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$MEMORY_STATUS</td></tr>
<tr><td>Disk</td><td class="status-$([[ "$DISK_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$DISK_STATUS</td></tr>
<tr><td>Wireless</td><td class="status-$([[ "$WIRELESS_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$WIRELESS_STATUS</td></tr>
<tr><td>Battery</td><td class="status-$([[ "$BATTERY_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$BATTERY_STATUS</td></tr>
<tr><td>Temperature</td><td class="status-$([[ "$TEMPERATURE_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$TEMPERATURE_STATUS</td></tr>
<tr><td>USB</td><td class="status-$([[ "$USB_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$USB_STATUS</td></tr>
<tr><td>PCI</td><td class="status-$([[ "$PCI_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$PCI_STATUS</td></tr>
<tr><td>Network</td><td class="status-$([[ "$NETWORK_STATUS" == "OK" ]] && echo "ok" || echo "failed")">$NETWORK_STATUS</td></tr>
</table>

</body>
</html>
EOF

  echo "HTML report generated: file://$PWD/$report_file"
}

# Check for HTML report option
if [[ "$1" == "--html" ]]; then
  HTML_REPORT=true
  shift # Remove the option from arguments
fi

# Basic System Information
# ... (same as before)

# Basic Hardware Information and Status (Read-Only)
# ... (same as before)

# Network Information (Read-Only)
# ... (same as before)

if $HTML_REPORT; then
  generate_html_report
else
  echo "--- Status Report ---"
  echo "CPU: $CPU_STATUS"
  echo "Memory: $MEMORY_STATUS"
  echo "Disk: $DISK_STATUS"
  echo "Wireless: $WIRELESS_STATUS"
  echo "Battery: $BATTERY_STATUS"
  echo "Temperature: $TEMPERATURE_STATUS"
  echo "USB: $USB_STATUS"
  echo "PCI: $PCI_STATUS"
  echo "Network: $NETWORK_STATUS"
fi

echo "--- End of Information Gathering and Status Report ---"
