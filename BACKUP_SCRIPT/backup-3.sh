#!/usr/bin/env bash

folders=(
    "./customers_data"
    "./inventory_data"
)

log_error() {
    echo "$1" >&2
    echo "$1" >> backup.log
}

exit_code=0
date_str=$(date '+%m-%d')

for folder in "${folders[@]}"; do
    folder_basename=$(basename "${folder}")
    archive_path="backups/${folder_basename//_/-}-${date_str}.tar.bz2"
    
    if ! tar -cjf "${archive_path}" "${folder}"; then
        log_error "[ERROR]: Tar of ${folder} could not be created"
        exit_code=1
    fi
done

./backup_db.sh | bzip2 > "backups/orders-${date_str}.sql.bz2"

exit ${exit_code}