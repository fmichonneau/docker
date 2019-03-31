#!/bin/sh

set -e

if [ -z "${BACKUP_ROTATIONS}" ]; then
  export BACKUP_ROTATIONS=5
fi

echo "[Entrypoint] Setup environment..."
echo
echo "[Entrypoint]    NEXTCLOUD_VOLUME = ${NEXTCLOUD_VOLUME}"
echo "[Entrypoint]    BACKUP_ROTATIONS = ${BACKUP_ROTATIONS}"
echo "[Entrypoint]       POSTGRES_HOST = ${POSTGRES_HOST}"
echo "[Entrypoint]         POSTGRES_DB = ${POSTGRES_DB}"
echo "[Entrypoint]       POSTGRES_USER = ${POSTGRES_USER}"
echo "[Entrypoint]   POSTGRES_PASSWORD = ********"

if [ "$1" = 'cron' ]; then
  echo "[Entrypoint]         CRON_PERIOD = '${CRON_PERIOD}'"
  echo

  echo "[Entrypoint] Initalize backup service....."
  echo "[Entrypoint] Installing cron: ${CRON_PERIOD}"

  # create backup-cron file...
  echo "${CRON_PERIOD} /usr/local/bin/backup.sh" >> /var/spool/cron/crontabs/root

  echo "[Entrypoint] Initalize backup service completed."
  echo "[Entrypoint] Starting cron...."
  echo

  # Run cron.....
  crond -l 2 -f
fi

if [ "$1" = 'backup' ]; then
  echo
  echo "[Entrypoint] Starting backup...."
  echo
  /bin/sh /usr/local/bin/backup.sh
fi

exec "$@"
