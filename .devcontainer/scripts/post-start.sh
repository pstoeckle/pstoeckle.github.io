#!/bin/sh
set -eu

# Fix git config ownership
git config --global --add safe.directory .

npm install \
    --package-lock-only=true
