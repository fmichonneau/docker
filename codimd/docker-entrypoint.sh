#!/bin/sh

set -e

echo "[Entrypoint] Waiting for database connection..."
echo

for i in `seq 10` ; do
  nc -z "${DB_HOST:-localhost}" "${DB_PORT:-5432}" > /dev/null 2>&1

  result=$?
  if [ $result -eq 0 ]; then
    echo "[Entrypoint] Database connection established"

    if [ $# -gt 0 ]; then
      echo "[Entrypoint] Starting application..."
      echo

      sed -i "s/change\ this/${DBMS}\:\/\/${DB_USER}\:${DB_PASSWORD}\@${DB_HOST}\:${DB_PORT}\/${DB_NAME}/g" .sequelizerc

      exec "$@"
    fi

    exit 0
  fi

  sleep 2
done

echo "[Entrypoint] Timeout. Database connection could not be established."

exit 1
