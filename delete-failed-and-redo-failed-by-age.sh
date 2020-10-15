#!/bin/bash
# IFS is set and unset for successful barman console output parsing
# step one: find failed barman backups
barman list-backup all | grep FAILED | cut -d ' ' -f-2 > /tmp/brmn.tmp
IFS=""
readarray -t backups < /tmp/brmn.tmp

# step two: delete found failed backups
for backup in "${backups[@]}"
do
        server=$(echo $backup | cut -d ' ' -f1)
        id=$(echo $backup | cut -d ' ' -f2)
        barman delete $server $id
done
rm -f /tmp/brmn.tmp

# step three: make backups for servers whose check report "failed by age" status
servers=$(barman check all --nagios | grep age | grep -v BARMAN | cut -d '.' -f1)
unset IFS
for server in $servers
do
        barman backup $server
done
