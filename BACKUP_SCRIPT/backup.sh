#!/usr/bin/env bash

date_str=$(date '+%m-%d')

tar -cjf "backups/customers-data-${date_str}.tar.bz2" "customers_data"
tar -cjf "backups/inventory-data-${date_str}.tar.bz2" "inventory_data"

./backup_db.sh | bzip2 > "backups/orders-${date_str}.sql.bz2"
