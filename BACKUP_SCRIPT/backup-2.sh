#!/usr/bin/env bash

date_str=$(date '+%m-%d')

folders=(
    "./customers_data"
    "./inventory_data"
)

for folder in "${folders[@]}"; do
    folder_basename=$(basename "${folder}")
    archive_path="backups/${folder_basename//_/-}-${date_str}.tar.bz2"
    
    tar -cjf "${archive_path}" "${folder}"
done

./backup_db.sh | bzip2 > "backups/orders-${date_str}.sql.bz2"
