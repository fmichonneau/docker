#!/bin/sh

date="$(date +%Y-%m-%d_%H:%M)"
file="/backups/${date}.dump.sql.gz"

echo "[Backup] ${date} *** Dumping MySQL database..."
mysqldump -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} | gzip -9 > "${file}"
echo "[Backup] ${date} *** Done"

if [ "$(ls -l /backups/*.dump.sql.gz | grep -v ^l | wc -l)" -gt "${BACKUP_ROTATIONS}" ]; then
  echo "[Backup] ${date} *** Removing deprecated dumps..."
  ls -F /backups/*.dump.sql.gz | head -n -${BACKUP_ROTATIONS} | xargs rm
  echo "[Backup] ${date} *** Done"
fi

echo "[Backup] ${date} *** Created database dump: ${file} ($(ls -l -h ${file} | cut -d " " -f18)B)"
echo "[Backup] ${date} *** Dump completed successfully."
echo

exit 0
