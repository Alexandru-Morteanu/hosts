cat /etc/hosts | while read -r ip name
do
  if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] && [[ ! -z $name ]]; then
    nslookup_ip=$(nslookup "$name" 2>/dev/null | grep "Address: " | tail -n 1 | awk '{print $2}')

    if [[ "$nslookup_ip" != "$ip" ]]; then
      echo "Bogus IP for $name in /etc/hosts!"
    fi
  fi
done