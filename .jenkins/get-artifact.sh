#!/bin/bash

echo "Collecting artifact"
cp -r ./.next/standalone/ ./build
cp -r ./public ./build
cp -r ./static ./build

echo "Zipping artifact"
zip -r build.zip build
