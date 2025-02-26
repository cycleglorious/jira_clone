#!/bin/bash

# Start the database
echo "Starting postgresql"
sudo docker run -d --rm \
	--name postgres-db \
	-e POSTGRES_PASSWORD=password \
  -p 5432:5432 \
  postgres

# Install dependencies
echo "Installing dependencies"
npm ci

# Create .env file for configs
echo "Creating .env file for configs"
echo "NODE_ENV='production'" >> .env
echo "DATABASE_URL='postgresql://postgres:password@localhost:5432'" >> .env
echo "UPSTASH_REDIS_REST_URL='http://localhost'" >> .env
echo "UPSTASH_REDIS_REST_TOKEN='token'" >> .env

# Migrate the database
echo "Migrating the database"
npx prisma db push

# Seed the database
echo "Seeding the database"
npx prisma db seed
