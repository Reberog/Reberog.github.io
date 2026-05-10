#!/bin/bash

# Portfolio GitHub Pages Deployment Script
# This script will initialize git, commit your code, and push to GitHub

set -e  # Exit on any error

echo "🚀 Portfolio GitHub Pages Deployment Script"
echo "============================================"
echo ""

# Step 1: Initialize Git
echo "📦 Step 1: Initializing Git repository..."
git init

# Step 2: Create .gitignore if it doesn't exist
if [ ! -f .gitignore ]; then
  echo "📝 Creating .gitignore..."
  cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Production
dist/
build/

# Misc
.DS_Store
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

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
Thumbs.db

# Local development
.cache/
.temp/
EOF
fi

# Step 3: Add all files
echo "📁 Step 2: Adding all files..."
git add .

# Step 4: Initial commit
echo "💾 Step 3: Creating initial commit..."
git commit -m "Initial commit: AI/ML Portfolio with auto-skills system

Features:
- Automatic project updates from GitHub
- AI-powered summaries using Gemini LLM
- Dynamic skills aggregation
- Real-time commit tracking
- Beautiful responsive design
"

# Step 5: Add remote
echo "🔗 Step 4: Adding GitHub remote..."
git remote add origin "https://github.com/Reberog/Reberog.github.io.git"

# Step 6: Set main branch
echo "🌿 Step 5: Setting main branch..."
git branch -M main

# Step 7: Push to GitHub
echo "⬆️  Step 6: Pushing to GitHub..."
echo ""
echo "⚠️  You will need to authenticate with GitHub"
echo "   If you have 2FA enabled, use a Personal Access Token instead of password"
echo ""
read -p "Press Enter to continue..."

git push -u origin main

echo ""
echo "✅ SUCCESS!"
echo "============================================"
echo ""
echo "Your code has been pushed to GitHub!"
echo ""
echo "Next steps:"
echo "1. Go to https://github.com/Reberog/Reberog.github.io/settings/pages"
echo "2. Under 'Build and deployment', set Source to 'GitHub Actions'"
echo "3. Go to the Actions tab and wait for deployment to complete"
echo "4. Visit https://reberog.github.io/ to see your portfolio!"
echo ""
echo "🎉 Your portfolio will be live in about 2-3 minutes!"
