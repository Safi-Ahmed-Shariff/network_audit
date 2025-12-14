# **🔐 Network Firewall & Security Audit Tool**

A Bash-based network and firewall auditing utility that helps quickly inspect a Linux system’s network exposure, firewall rules, and active connections — with the ability to export a full audit report in JSON format.  
This project simulates real-world Cloud Support / DevOps security triage, where engineers need fast visibility into ports, services, and firewall behavior.  

## **🚀 Project Overview**

The script provides an interactive menu that allows you to:
1. Inspect open network ports
2. Review firewall rules (UFW)
3. Identify blocked IP addresses (iptables)
4. View active network connections
5. List listening services with ports
6. Export the full audit into a structured JSON file

All results are gathered using standard Linux networking tools and consolidated into one place.

## **⭐ Features**
✔ Open Port Inspection  
- Lists all open ports using ss, helping identify exposed services.  

✔ Firewall Rule Review  
- Displays current UFW firewall rules to verify allowed and denied traffic.

✔ Blocked IP Detection  
- Extracts IPs blocked via iptables INPUT DROP rules.

✔ Active Connection Monitoring  
- Shows all currently established network connections.

✔ Listening Services  
- Maps running services to their listening ports.

✔ JSON Export  
- Exports the entire audit snapshot into a structured JSON file for logging, sharing, or automation.

## **🖥️ Project Structure**
network-audit/  
│  
├── firewall_audit.sh  
└── audit.json        # Generated output (after export)

## **📸 Screenshots**
Recommended screenshots to include in this repository:  
1. Interactive Menu – Shows available audit options
2. Terminal Output – Displays open ports, firewall rules, and connections
3. Core Script Logic – Bash functions using ss, ufw, and iptables
4. JSON Export Logic – Conversion of command output into JSON
5. Final JSON Output – Complete audit report

## **▶️ Usage**
1. Make the script executable  
- chmod +x firewall_audit.sh

2. Run the tool  
- sudo ./firewall_audit.sh

3. Export JSON Audit
- Select option 6 from the menu to generate the JSON report:  
  - /home/safi/Desktop/network/audit.json

## **📦 Dependencies**

The script relies on standard Linux utilities:  
- ss  
- ufw  
- iptables  
- awk  
- sort  
- uniq  
Optional (for JSON export):  
- jq  
  - If jq is not installed, install it using:  
  - sudo apt install jq  


## **🧠 How It Works**

- Each audit function collects real-time system data  
- Output is printed to the terminal for immediate inspection  
- When exporting, command outputs are transformed into JSON arrays using jq  
- The final JSON report includes:
  - Timestamp  
  - Open ports  
  - Firewall rules  
  - Blocked IPs  
  - Active connections  
  - Listening services

This design allows both human-readable and machine-readable audits.  

## **🎯 Learning Outcomes**

This project helped me practice:
- Linux networking fundamentals  
- Firewall inspection (UFW & iptables)  
- Port and service auditing  
- Security-oriented troubleshooting  
- Bash scripting and automation  
- JSON report generation  

## **🔮 Future Enhancements**

- Scheduled audits using cron or systemd timers  
- Alerting on newly opened ports  
- Historical comparison of audit reports  
- Cloud equivalents (AWS Security Groups mapping)  
- Integration with centralized logging systems  
