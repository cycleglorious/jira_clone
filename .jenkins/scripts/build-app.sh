#!/bin/bash

# Build the app
echo "Building the app"
npm run build

# Collect the artifact
echo "Collecting artifact"
cp -r .next/standalone/ build
cp -r .next/static build/.next/
rm build/.env

# Zip the artifact
echo "Zipping artifact"
zip -r build.zip build
