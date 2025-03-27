# ThinkPad X220 Hardware Information and Status Script

This Bash script gathers hardware information and reports the status of various components of a ThinkPad X220 (or similar Linux system). It's designed to be read-only and does not perform any actions that could modify the system's state.

## Features

* **System Information:** Displays basic system details like kernel version, CPU model, memory usage, and disk space.
* **Hardware Information:** Collects and displays information about the CPU, memory, disk, wireless interface, battery, temperature, USB devices, PCI devices, and network interfaces.
* **Status Reporting:** Provides a summary of the status of each hardware component, indicating whether it's working ("OK") or if an error occurred ("FAILED").
* **Offline-Friendly:** Does not require an internet connection.
* **Read-Only:** No system modifications are performed.

## Requirements

* A Linux-based operating system (tested on systems compatible with the ThinkPad X220).
* Bash shell.
* `sudo` (for disk information).
* `lm-sensors` (for temperature information).
* `hdparm` (for disk information).

## Installation

1.  Save the script to a file (e.g., `x220_status.sh`).
2.  Make the script executable: `chmod +x x220_status.sh`.
3.  (Optional) Install `lm-sensors` for temperature information: `sudo apt install lm-sensors`. After install run `sudo sensors-detect` and follow the prompts.
4.  (Optional) Install `hdparm` for disk information: `sudo apt install hdparm`.

## Usage

* To run the script and gather all information (including disk information), use: `sudo ./x220_status.sh`
* To run the script without disk information (no `sudo` required): `./x220_status.sh`

## Output

The script outputs information to the terminal, including:

* System information.
* Detailed hardware information.
* A status report indicating the working status of each component.

## Status Reporting

The script uses the following status indicators:

* **OK:** The component is working as expected.
* **FAILED:** An error occurred while gathering information about the component.

## Notes

* The disk information requires `sudo` privileges.
* The temperature information requires `lm-sensors` to be installed and configured.
* The network status checks for the existance of network interfaces, not internet connectivity.
* This script is intended for informational purposes and basic hardware status checks. For thorough hardware testing, consider using specialized diagnostic tools.



i don't know if the html tester works so keep that in mind
