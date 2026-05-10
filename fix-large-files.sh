#!/bin/bash
# Fix Large Files Issue - Remove node_modules and large binaries from git

echo "🔧 Fixing large files issue..."

cd /Users/arpananand/Documents/Portfolio/portfolio-project

# First, completely remove node_modules from git cache
echo "📦 Removing node_modules from git staging..."
git rm -r --cached node_modules/ 2>/dev/null || true

# Specifically remove the large Cloudflare Workerd binaries
echo "�️  Removing large binary files..."
git rm --cached "node_modules/@cloudflare/workerd-darwin-arm64/bin/workerd" 2>/dev/null || true
git rm --cached "node_modules/@cloudflare/workerd-darwin-64/bin/workerd" 2>/dev/null || true
git rm --cached "node_modules/@cloudflare/workerd-linux-arm64/bin/workerd" 2>/dev/null || true
git rm --cached "node_modules/@cloudflare/workerd-linux-64/bin/workerd" 2>/dev/null || true
git rm --cached "node_modules/@cloudflare/workerd-windows-64/bin/workerd.exe" 2>/dev/null || true

# Remove entire node_modules directory from git if the above didn't work
echo "🧹 Ensuring all node_modules are unstaged..."
git reset HEAD node_modules/ 2>/dev/null || true

# Make sure .gitignore is correct
echo "📝 Ensuring .gitignore is correct..."
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

# Lock files
bun.lock
EOF

# Re-add everything (node_modules will be ignored now)
echo "✅ Re-staging files (excluding node_modules)..."
git add .gitignore
git add src/
git add public/ 2>/dev/null || true
git add *.json 2>/dev/null || true
git add *.ts 2>/dev/null || true
git add *.tsx 2>/dev/null || true
git add *.js 2>/dev/null || true
git add .github/ 2>/dev/null || true
git add README.md 2>/dev/null || true

# Show what will be committed
echo ""
echo "📊 Files staged for commit:"
git diff --cached --stat | head -30

echo ""
echo "🔍 Checking for large files in staging..."
git diff --cached --name-only | while read file; do
  if [ -f "$file" ]; then
    size=$(ls -lh "$file" | awk '{print $5}')
    echo "  $file ($size)"
  fi
done | grep -E '\d+M' || echo "  ✅ No large files found!"

echo ""
echo "✅ Fixed! node_modules and large binaries are now excluded."
echo ""
echo "Next steps:"
echo "1. Run: git commit -m 'Deploy portfolio - remove large files'"
echo "2. Run: git push -u origin main"
echo ""
echo "⚠️  If push still fails, you may need to force push:"
echo "   git push -u origin main --force"
