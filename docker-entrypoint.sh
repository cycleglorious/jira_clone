#!/bin/sh
set -e

if [ "$RUN_MIGRATIONS" = "true" ]; then
  echo "Running Prisma migrations..."
  npx prisma db push --skip-generate
else
  echo "Skipping Prisma migrations..."
fi

if [ "$RUN_SEEDING" = "true" ]; then
  echo "Running Prisma seeding..."
  npm install @prisma/client --no-package-lock --no-save
  npx prisma db seed
else
  echo "Skipping Prisma seeding..."
fi

if [ "$IS_BATCH_MODE" = "true" ]; then
  echo "Batch process completed. Exiting..."
  exit 0
fi

exec "$@"
