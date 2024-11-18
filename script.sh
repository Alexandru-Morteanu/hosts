cția pentru verificarea validității unei adrese IP
check_ip() {
    local hostname=$1
    local ip=$2   
    local dns_server=$3 

    resolved_ip=$(nslookup $hostname $dns_server 2>/dev/null | grep 'Address:' | tail -n1 | awk '{print $2}')

    if [[ "$resolved_ip" == "$ip" ]]; then
        echo "Adresa IP pentru $hostname este validă."
    else
        echo "Bogus IP for $hostname! (Așteptat: $ip, Rezolvat: $resolved_ip)"
    fi
}

cat /etc/hosts | while read ip dom
do
    if [[ "$ip" == \#* || -z "$ip" ]]; then
        continue
    fi

    check_ip "$dom" "$ip" "8.8.8.8"
done