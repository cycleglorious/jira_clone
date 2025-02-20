#!/bin/bash

echo "Collecting artifact"
cp -r .next/standalone/ build
cp -r .next/static build/.next/
rm build/.env

echo "Zipping artifact"
zip -r build.zip build
