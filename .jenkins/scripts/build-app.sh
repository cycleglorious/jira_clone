#!/bin/bash

# Get the zip file name
ZIP_NAME=$1

# Build the app
echo "Building the app"
npm run build

# Collect the artifact
echo "Collecting artifact"
cp -r .next/standalone/ build
cp -r .next/static build/.next/
rm build/.env

# Zip the artifact with the variable zip name
echo "Zipping artifact"
cd build
zip -r "../$ZIP_NAME" .

