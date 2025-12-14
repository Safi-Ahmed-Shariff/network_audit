export_file="/home/safi/desktop/network/audit.json"

header() {
	echo " "
	ts=$(date '+%Y-%m-%d %H:%M:%S')
	echo "---$1---[$ts]---"
	echo " "
}

open_port() {
	echo " "
	header 'OPEN PORTS'
	out=$(ss -tulnp | awk 'NR>1 {print $5}' | awk -F ':' '{print $NF}' | sort -n | uniq)
	echo "$out"
	echo " "
}

firewall_rules() {
	echo " "
	header 'FIREWALL RULES'
	ufw status
	echo " "
}

blocked_ip() {
	echo " "
	header 'BLOCKED IPs'
	out=$(iptables -L INPUT -v -n | awk '/DROP/ {print $9}')
  if [ -z "$out" ]; then
    echo "No Blocked IPs"
  else
	  echo "$out"
  fi
	echo " "
}

active_conn() {
	echo " "
	header 'ACTIVE CONNECTION'
	out=$(ss -tulnp state established)
	echo "$out"
	echo " "
}
listening_services() {
	echo " "
	header 'LISTENING SERVICES'
	out=$(ss -tulnp | awk 'NR>1 {split($5,a,":"); port=a[length(a)]; split($NF,b,","); print b[2], port}')
	echo "$out"
	echo " "
}

echo " "
echo "---NETWORK AUDIT---[$(date '+%Y-%m-%d %H:%M:%S')]"
echo "1.Show open ports"
echo "2.Show firewall rules"
echo "3.Show blocked IP's"
echo "4.Show active connections"
echo "5.Show listening services"
echo "6.Export JSON"
echo "7.Exit"
echo " "

while true; do
read -p "Enter your choice:" choice

case $choice in
	1)open_port;;
	2)firewall_rules;;
	3)blocked_ip;;
	4)active_conn;;
	5)listening_services;;
	6)
    echo "Exporting JSON..."

    open_ports=$(ss -tulnp | awk 'NR>1 {split($5,a,":"); print a[length(a)]}' | sort -n | uniq | jq -R . | jq -s .)

    firewall_rules=$(ufw status)

    blocked_ips=$(iptables -L INPUT -v -n | awk '/DROP/ {print $9}' | jq -R . | jq -s .)

    active_connections=$(ss -tunp state established | jq -R . | jq -s .)

    listening_services=$(ss -tulnp | awk 'NR>1 {
        split($5,a,":"); port=a[length(a)];
        split($NF,b,","); print b[2] " " port
    }' | jq -R . | jq -s .)

    jq -n \
      --arg timestamp "$(date '+%Y-%m-%d %H:%M:%S')" \
      --argjson open_ports "$open_ports" \
      --arg firewall_rules "$firewall_rules" \
      --argjson blocked_ips "$blocked_ips" \
      --argjson active_connections "$active_connections" \
      --argjson listening_services "$listening_services" \
      '{
          timestamp: $timestamp,
          open_ports: $open_ports,
          firewall_rules: $firewall_rules,
          blocked_ips: $blocked_ips,
          active_connections: $active_connections,
          listening_services: $listening_services
       }' > "$export_file"

    echo "JSON saved to $export_file"
;;


	7)exit;;
	*)echo "Invalid Choice";;
esac
done
