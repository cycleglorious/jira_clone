#!/bin/bash

echo "Collecting artifact"
cp -r ./.next/standalone/ ./build
cp -r ./public ./build/.next
cp -r ./.next/standalone ./build/.next/

echo "Zipping artifact"
zip -r build.zip build
