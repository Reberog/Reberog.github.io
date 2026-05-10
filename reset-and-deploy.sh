#!/bin/bash
# Complete Reset and Deploy - Start fresh with only necessary files

echo "🔄 Complete Git Reset and Deploy Script"
echo "========================================"
echo ""
echo "⚠️  WARNING: This will completely reset your git repository!"
echo "Press CTRL+C to cancel, or ENTER to continue..."
read

cd /Users/arpananand/Documents/Portfolio/portfolio-project

# Step 1: Remove the .git folder completely
echo "🗑️  Step 1: Removing .git folder..."
rm -rf .git

# Step 2: Initialize a new git repository
echo "📦 Step 2: Initializing new git repository..."
git init
git branch -M main

# Step 3: Ensure .gitignore is correct
echo "📝 Step 3: Creating .gitignore..."
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Build output
dist/
build/
.output/
.vinxi/
.vercel/

# Environment
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
pnpm-debug.log*

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Cache
.cache/
.temp/
.lovable/
.workspace/

# Lock files (optional - uncomment if needed)
# bun.lock
# package-lock.json
# yarn.lock
EOF

# Step 4: Add only the necessary files
echo "✅ Step 4: Adding necessary files..."
git add .gitignore
git add package.json
git add tsconfig.json
git add vite.config.ts
git add components.json 2>/dev/null || true
git add eslint.config.js 2>/dev/null || true
git add wrangler.jsonc 2>/dev/null || true
git add README.md 2>/dev/null || true
git add src/
git add .github/
git add public/ 2>/dev/null || true

# Step 5: Show what will be committed
echo ""
echo "📊 Files to be committed:"
git status --short

echo ""
echo "📦 Total size of staged files:"
git ls-files | xargs ls -lh | awk '{total += $5} END {print total/1024/1024 " MB"}'

# Step 6: Create initial commit
echo ""
echo "💾 Step 5: Creating initial commit..."
git commit -m "Initial commit: Portfolio project

- TanStack Start + Vite + React portfolio
- Configured for static GitHub Pages deployment
- Excludes node_modules and build artifacts"

# Step 7: Add remote and push
echo ""
echo "🚀 Step 6: Adding remote and pushing..."
git remote add origin https://github.com/reberog/reberog.github.io.git

echo ""
echo "⚠️  About to force push to GitHub..."
echo "Press CTRL+C to cancel, or ENTER to continue..."
read

git push -u origin main --force

echo ""
echo "✅ Done! Repository has been reset and pushed."
echo ""
echo "Next steps:"
echo "1. Check GitHub Actions at: https://github.com/reberog/reberog.github.io/actions"
echo "2. Once the workflow completes, visit: https://reberog.github.io"
echo ""
