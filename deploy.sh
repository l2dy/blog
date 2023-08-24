#!/usr/bin/env bash

# If a command fails then the deploy stops
set -e

# Use UTC timezone
export TZ=UTC

if [ ! -d "node_modules" ]; then
  printf "\033[0;32mInstalling dependencies...\033[0m\n"
  npm ci
fi

if [ ! -d "public-io/.git" ]; then
  rm -rf public-io
  printf "\033[0;32mCloning public repository...\033[0m\n"
  git clone git@github.com:l2dy/l2dy.github.io.git public-io
fi

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Copy files from iCloud.
rsync --cvs-exclude --omit-link-times --archive --delete ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/pkm/Garden/ content

# Build the project.
npx --offline quartz build

rsync --cvs-exclude --omit-link-times --archive --delete --verbose public/ public-io/

# Go To Public folder
cd public-io

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
  msg="$*"
fi
git commit -m "$msg" || true

# Push source and build repos.
git push --force-with-lease origin master
