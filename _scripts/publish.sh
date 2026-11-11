#!/usr/bin/env bash
# Publish to github pages on gh-pages branch

# Stop at the first failing command, so a failed checkout of gh-pages can
# never wipe and commit over the source branch.
set -euo pipefail

if [ -n "$(git status --porcelain)" ]; then
  echo "Please commit all changes before publishing with this script"
  exit 1
fi

if [ ! -f "_config.yml" ]; then
  echo "Please run this script from the base project directory"
  exit 1
fi

commit_hash=$(git rev-parse HEAD)
branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$branch" = "gh-pages" ]; then
  echo "Run this script from the source branch (e.g. main), not gh-pages"
  exit 1
fi

rm -rf "/tmp/publish.d" "/tmp/gh-pages-publish"
if [ -d "_scripts/publish.d" ]; then
  cp -r "_scripts/publish.d" "/tmp/publish.d"
fi
bundle exec jekyll b -d /tmp/gh-pages-publish

# A build can touch tracked files (e.g. .jekyll-cache); discard that so the
# branch switch below is not blocked by local changes.
git checkout -- .
git checkout gh-pages
if [ "$(git rev-parse --abbrev-ref HEAD)" != "gh-pages" ]; then
  echo "Could not switch to gh-pages; aborting without changes"
  exit 1
fi
git pull
git ls-files -z -- . ':!:.git*' | xargs -0 rm -f
cp -r /tmp/gh-pages-publish/* .
if [ -d "/tmp/publish.d" ]; then
  for script in /tmp/publish.d/*.sh; do
    if [ -e "$script" ]; then bash "$script"; fi
  done
fi
git add .
git commit -m "publish commit ${commit_hash}"
git push
git checkout "${branch}"
