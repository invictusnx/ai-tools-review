#!/bin/bash
# AI Tools Review — Deploy to GitHub Pages
# Run: bash scripts/deploy.sh "commit message"

set -e

SITE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$SITE_DIR"

MSG="${1:-Auto-update: new review post}"

# Check git status
if [ ! -d .git ]; then
  echo "❌ No git repo. Create one first:"
  echo "   gh repo create ai-tools-review --public --push --source=."
  echo "   (or manually on github.com)"
  exit 1
fi

# Stage all changes
git add -A

# Only commit if there are changes
if git diff --cached --quiet; then
  echo "✓ No changes to deploy"
  exit 0
fi

git commit -m "$MSG"
git push origin main

echo "✓ Deployed! Wait ~2 min for GitHub Pages to update."
echo "  Your site: https://aitoolsreview.site"