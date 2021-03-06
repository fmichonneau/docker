#!/bin/sh

set -e

log() {
  echo "[Entrypoint] ${1}"
  return 0
}

if [ -z "${BACKUP_ROTATIONS}" ]; then
  export BACKUP_ROTATIONS=4
fi

log "Setup environment..."
echo
log "   NEXTCLOUD_VOLUME = ${NEXTCLOUD_VOLUME}"
log "   BACKUP_ROTATIONS = ${BACKUP_ROTATIONS}"
log "      POSTGRES_HOST = ${POSTGRES_HOST}"
log "        POSTGRES_DB = ${POSTGRES_DB}"
log "      POSTGRES_USER = ${POSTGRES_USER}"
log "  POSTGRES_PASSWORD = ********"

if [ "$1" = "cron" ]; then
  log "        CRON_PERIOD = ${CRON_PERIOD}"
  echo

  log "Initialize backup service....."
  log "Installing cron: ${CRON_PERIOD}"

  # create backup-cron file...
  echo "${CRON_PERIOD} /usr/local/bin/backup" >> /var/spool/cron/crontabs/root

  log "Initialize backup service completed."
  log "Starting cron...."
  echo

  # Run cron.....
  crond -l 2 -f
fi

if [ "$1" = "backup" ]; then
  echo
  log "Starting backup...."
  echo
  BACKUP_ROTATIONS=${BACKUP_ROTATIONS} /bin/sh /usr/local/bin/backup
fi

exit 0
