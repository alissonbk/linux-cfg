#!/bin/sh

#day=$( date +%d );
#month=$( date +%m );
ls_cmd=$( docker exec -it zeitdb /bin/ls -t /var/lib/postgresql/data/pg_log | awk 'NR==1{print $1}' );
full_path=$( /var/lib/postgresql/data/pg_log/$ls_cmd )
follow_cmd="-f"
num_lines=10

if [[ $1 == $follow_cmd ]];
then
	echo "/var/lib/postgresql/data/pg_log/$ls_cmd"
	docker exec -it zeitdb /bin/tail -n $num_lines -f /var/lib/postgresql/data/pg_log/$ls_cmd
else
	docker exec -it zeitdb /bin/tail -n $num_lines /var/lib/postgresql/data/pg_log/$ls_cmd
fi
