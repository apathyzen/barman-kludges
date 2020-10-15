# barman-kludges
Lazy but working bash scripts to fix errors occuring in pgbarman backups
Work with barman 2.11

Use them with cron accordingly to your backup schedule

# delete-failed-and-redo-failed-by-age.sh
Pretty simple — sometimes full backups fail, this one deletes failed backups and asks for anothers
You could use it early in the morning, when usual backup schedule should be already completed

# passive-barman-node-resync.sh
There's a strange issue on passive node when barman reports ERROR: Failed to retrieve the primary node status: sync-info execution on remote primary server
This one forces barman to sync-info, sync wals and then resync backups with primary node
Works good when set to run every two hours or so
