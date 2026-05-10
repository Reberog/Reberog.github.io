#!/bin/bash
# Initialize Git Repository and Deploy

echo "🔧 Setting up Git repository..."
cd /Users/arpananand/Documents/Portfolio/portfolio-project

# Remove broken git reference
echo "📦 Removing broken git reference..."
rm -f .git
rm -rf .git

# Initialize new git repository
echo "🎯 Initializing new git repository..."
git init
git branch -M main

# Configure git (if needed)
git config user.name "Reberog" 2>/dev/null || true
git config user.email "your-email@example.com" 2>/dev/null || true

# Ensure .gitignore is present
echo "📝 Verifying .gitignore..."
if [ ! -f .gitignore ]; then
    echo "Creating .gitignore..."
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
EOF
fi

# Add files
echo "✅ Adding files to git..."
git add .gitignore
git add package.json tsconfig.json vite.config.ts
git add components.json eslint.config.js wrangler.jsonc 2>/dev/null || true
git add src/
git add .github/
git add README.md QUICK_FIX.md DEPLOYMENT_GUIDE.md 2>/dev/null || true
git add api/ 2>/dev/null || true

# Show status
echo ""
echo "📊 Files to be committed:"
git status --short

echo ""
echo "📦 Checking for large files..."
large_files=$(find . -type f -size +10M ! -path "*/node_modules/*" ! -path "*/.git/*" 2>/dev/null)
if [ -z "$large_files" ]; then
    echo "✅ No large files found in git staging!"
else
    echo "⚠️  Large files found (these should NOT be committed):"
    echo "$large_files"
fi

echo ""
echo "🚀 Creating commit..."
git commit -m "Initial commit: Portfolio project

- TanStack Start + Vite + React
- GitHub Actions deployment workflow
- Excludes node_modules and build artifacts
- Ready for GitHub Pages deployment"

echo ""
echo "🔗 Adding remote repository..."
git remote add origin https://github.com/reberog/reberog.github.io.git 2>/dev/null || true
git remote set-url origin https://github.com/reberog/reberog.github.io.git

echo ""
echo "📤 Pushing to GitHub..."
echo "⚠️  This will force push to overwrite any existing content!"
echo "Press CTRL+C to cancel, or press ENTER to continue..."
read

git push -u origin main --force

echo ""
echo "✅ Done! Your repository has been set up and pushed."
echo ""
echo "Next steps:"
echo "1. Check GitHub Actions: https://github.com/reberog/reberog.github.io/actions"
echo "2. Wait for build to complete (2-3 minutes)"
echo "3. Visit your site: https://reberog.github.io"
echo ""
