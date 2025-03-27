#!/bin/bash

# ThinkPad X220 Hardware Information and Status (Offline-Friendly)

# Variables to track status
CPU_STATUS="OK"
MEMORY_STATUS="OK"
DISK_STATUS="OK"
WIRELESS_STATUS="OK"
BATTERY_STATUS="OK"
TEMPERATURE_STATUS="OK"
USB_STATUS="OK"
PCI_STATUS="OK"
NETWORK_STATUS="OK" #added network status

# Basic System Information
echo "--- System Information ---"
echo "Kernel:"
uname -a
echo "CPU Model:"
cat /proc/cpuinfo | grep "model name" | head -n 1
echo "Memory:"
free -h | grep Mem
echo "Disk Space:"
df -h /dev/sda1 2>/dev/null # Adjust /dev/sda1 if needed, suppress errors if not found.
echo "--- Network ---"
ip a | grep "inet "
echo "Wireless Interface:"
iwconfig 2>/dev/null | grep ESSID
echo "--- Battery ---"
acpi -b 2>/dev/null # Suppress errors if no battery
echo "--- Temperature ---"
sensors 2>/dev/null | grep Core # Suppress errors if sensors not installed
echo "--- PCI Devices ---"
lspci
echo "--- USB Devices ---"
lsusb

# Basic Hardware Information and Status (Read-Only)

echo "--- Basic Hardware Information and Status ---"

# CPU Information (Read-Only)
echo "CPU Information (Read-Only)..."
cat /proc/cpuinfo | grep -E "processor|vendor_id|model name|cpu MHz|cache size"
echo "CPU Information gathered."

# Memory Information (Read-Only)
echo "Memory Information (Read-Only)..."
free -h
echo "Memory Information gathered."

# Disk Information (Read-Only)
echo "Disk Information (Read-Only)..."
sudo hdparm -I /dev/sda 2>/dev/null | grep -E "Model Number|Serial Number|Firmware Revision|Transport" # Replace /dev/sda as needed.
if [ $? -ne 0 ]; then
  DISK_STATUS="FAILED"
fi
echo "Disk Information gathered."

# Wireless Information (Read-Only)
echo "Wireless Information (Read-Only)..."
iwconfig 2>/dev/null
if [ $? -ne 0 ]; then
  WIRELESS_STATUS="FAILED"
fi
echo "Wireless Information gathered."

# Battery Information (Read-Only)
echo "Battery Information (Read-Only)..."
acpi -b 2>/dev/null
if [ $? -ne 0 ]; then
  BATTERY_STATUS="FAILED"
fi
echo "Battery Information gathered."

# Temperature Information (Read-Only)
echo "Temperature Information (Read-Only)..."
sensors 2>/dev/null
if [ $? -ne 0 ]; then
  TEMPERATURE_STATUS="FAILED"
fi
echo "Temperature Information gathered."

# USB Information (Read-Only)
echo "USB Information (Read-Only)..."
lsusb
if [ $? -ne 0 ]; then
  USB_STATUS="FAILED"
fi
echo "USB Information gathered."

# PCI Information (Read-Only)
echo "PCI Information (Read-Only)..."
lspci
if [ $? -ne 0 ]; then
  PCI_STATUS="FAILED"
fi
echo "PCI Information gathered."

# Network Information (Read-Only)
echo "Network Information (Read-Only)..."
ip a
if [ $? -ne 0 ]; then
    NETWORK_STATUS="FAILED"
fi
echo "Network Information gathered."

echo "--- Status Report ---"
echo "CPU: $CPU_STATUS"
echo "Memory: $MEMORY_STATUS"
echo "Disk: $DISK_STATUS"
echo "Wireless: $WIRELESS_STATUS"
echo "Battery: $BATTERY_STATUS"
echo "Temperature: $TEMPERATURE_STATUS"
echo "USB: $USB_STATUS"
echo "PCI: $PCI_STATUS"
echo "Network: $NETWORK_STATUS" #added network status to report

echo "--- End of Information Gathering and Status Report ---"
