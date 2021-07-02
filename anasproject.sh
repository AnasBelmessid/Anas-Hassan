
rm scores.txt
rm ad.txt
grep -E -o '([0-9]{1,3}[\.]){3}[0-9]{1,3}' projet.log > ad.txt
while read line; do
score=$(curl -G -s https://api.abuseipdb.com/api/v2/check --data-urlencode "ipAddress=$line" -d maxAgeInDays=90  -H "key=6f2826532336cbb65f038f3abd2893b15e4fb568d32e9989003647277274380a9e607372324ddb66" -H "Accept:application/json" | jq '.data.abuseConfidenceScore');

     if [ $score -ge 25 ]; then
      iptables -A INPUT -s $line -j DROP
      echo $line >> ip.txt
      echo $score >> scores.txt
     fi
done < ad.txt







