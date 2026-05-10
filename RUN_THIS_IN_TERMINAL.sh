#!/bin/bash
# ============================================
# COPY AND PASTE THESE COMMANDS INTO YOUR MAC TERMINAL
# ============================================
#
# These commands will:
# 1. Initialize git repository
# 2. Add all your files
# 3. Commit them
# 4. Push to GitHub
#
# Run these commands ONE BY ONE or all at once
# ============================================

# Navigate to your project folder
cd /Users/arpananand/Documents/Portfolio/portfolio-project

# Create .gitignore file
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Production
dist/
build/

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
EOF

# Initialize git repository
git init

# Configure git (replace with your details if different)
git config user.name "Reberog"
git config user.email "your-email@example.com"

# Add all files
git add .

# Make initial commit
git commit -m "Initial commit: AI/ML Portfolio with auto-skills system

Features:
- Automatic project updates from GitHub
- AI-powered summaries using Gemini LLM
- Dynamic skills aggregation
- Real-time commit tracking
- Beautiful responsive design
- GitHub Pages deployment"

# Add GitHub remote
git remote add origin https://github.com/Reberog/Reberog.github.io.git

# Set main branch
git branch -M main

# Push to GitHub
echo ""
echo "🚀 Pushing to GitHub..."
echo "⚠️  You will be prompted for your GitHub credentials"
echo "   Username: Reberog"
echo "   Password: Use a Personal Access Token (not your GitHub password)"
echo ""
echo "   Get a token at: https://github.com/settings/tokens"
echo "   Select scope: 'repo' (Full control of private repositories)"
echo ""

git push -u origin main

# Success message
echo ""
echo "============================================"
echo "✅ SUCCESS! Your code is on GitHub!"
echo "============================================"
echo ""
echo "Next steps:"
echo "1. Go to: https://github.com/Reberog/Reberog.github.io/settings/pages"
echo "2. Under 'Build and deployment', set Source to 'GitHub Actions'"
echo "3. Go to the Actions tab and watch the deployment"
echo "4. In 2-3 minutes, visit: https://reberog.github.io/"
echo ""
echo "🎉 Your portfolio will be LIVE!"
echo ""
