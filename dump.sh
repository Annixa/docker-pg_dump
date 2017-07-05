#!/bin/bash

set -e

echo "Job started: $(date)"

DATE=$(date +%Y%m%d_%H%M%S)
FILE="/dump/$PREFIX-$DATE.sql"

pg_dump -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -f "$FILE" -d "$PGDB" 
gzip "$FILE"

if [ ! -z "$DELETE_OLDER_THAN" ]; then
	echo "Deleting old backups: $DELETE_OLDER_THAN"
	find /dump/* -mmin "+$DELETE_OLDER_THAN" -exec rm {} \;
fi



echo "Job finished: $(date)"
