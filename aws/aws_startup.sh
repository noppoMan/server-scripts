#use for getting local ip addr and hsotname with dynamic
/opt/ec2-api-tools/bin/ec2-describe-instances --region ap-northeast-1 -H --show-empty-fields | gawk 'BEGIN {OFS="\t"; print "127.0.0.1","localhost localhost.localdomain"}/^INSTAN\
CE/ {ip = $19}  /^TAG/ {print ip, gensub(/.*\tName\t([^\t]*).*/, "\\1", $0)}  '> /etc/hosts