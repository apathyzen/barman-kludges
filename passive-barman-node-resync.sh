#!/bin/bash
# A solution for issue in https://groups.google.com/g/pgbarman/c/P0Q6AZ-Mi9o/m/y_PiF2WJBQAJ when passive node suddenly fails to retrieve the primary node status
# After running this passive node successfully resyncs all backups
# Works with barman 2.11

servers=$(tail -n 50 /var/log/barman/barman.log | grep -oP '(?<=primary server )[^ ]*' | sort | uniq)
for server in $servers
do
        barman sync-info --primary $server
        barman sync-wals $server
done
