#!/bin/bash
set -e

# Commit and tag this change.
version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`

git config --global user.email "83490846+github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]"

git commit -m "Bump version to $version" ./pubspec.yaml
git tag $version