#!/bin/bash
# COPY-PASTE THIS ENTIRE BLOCK INTO MAC TERMINAL

cd /Users/arpananand/Documents/Portfolio/portfolio-project

echo "🔧 Removing node_modules from git..."
git reset HEAD node_modules/ 2>/dev/null || true
git rm -r --cached node_modules/ 2>/dev/null || true

echo "✅ Adding only source files..."
git add .gitignore
git add src/
git add package.json tsconfig.json vite.config.ts components.json eslint.config.js wrangler.jsonc
git add .github/ 2>/dev/null || true
git add README.md 2>/dev/null || true

echo ""
echo "📊 Files to be committed:"
git status --short

echo ""
echo "🚀 Ready to commit and push!"
echo ""
echo "Run these commands next:"
echo "  git commit -m 'Deploy portfolio - exclude node_modules'"
echo "  git push -u origin main --force"
