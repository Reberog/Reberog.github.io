#!/bin/bash
# Fix Git Configuration and Deploy

echo "🔧 Preparing portfolio for deployment..."

# Navigate to project
cd /Users/arpananand/Documents/Portfolio/portfolio-project

# Remove documentation markdown files (not needed in repo)
echo "🧹 Cleaning up documentation files..."
rm -f AI_RANKING_GUIDE.md
rm -f ARCHITECTURE_ONLY_IMPLEMENTATION.md
rm -f AUTO_SKILLS_SYSTEM.md
rm -f AUTO_SUMMARY_UPDATE.md
rm -f AUTO_UPDATE_SYSTEM.md
rm -f CHANGELOG.md
rm -f COPY_PASTE_COMMANDS.txt
rm -f DEPLOY_NOW.md
rm -f GEMINI_INTEGRATION_GUIDE.md
rm -f GITHUB_FETCHING_VERIFIED.md
rm -f GITHUB_PAGES_DEPLOYMENT.md
rm -f HOW_TO_UPDATE_COMMITS.md
rm -f INTERACTIVE_DIAGRAMS.md
rm -f MERMAID_INTEGRATION.md
rm -f PROJECT_RANKING_README.md
rm -f QUICKSTART.md
rm -f QUICK_REFERENCE.md
rm -f QUICK_START.md
rm -f RUN_THIS_IN_TERMINAL.sh
rm -f SETUP_GUIDE.md
rm -f SKILLS_PLACEMENT.md
rm -f SKILLS_SYSTEM.md
rm -f WHERE_IS_GEMINI.md
rm -f deploy-commands.sh
rm -f deploy-to-github.sh
rm -f setup-ranking.sh
rm -f update-rankings.sh
rm -f test-fetch.html
rm -f update-projects.js

# Remove any existing git configuration
echo "🔄 Resetting git repository..."
rm -rf .git 2>/dev/null

# Unset any problematic git environment variables
unset GIT_DIR
unset GIT_WORK_TREE

# Initialize fresh git repository
git init

# Configure git
git config user.name "Reberog"
git config user.email "arpananand1903@gmail.com"

# Update .gitignore
echo "📝 Updating .gitignore..."
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
.netlify/

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

# Lock files (optional - keep if you want consistent installs)
# bun.lock
EOF

# Add all files
echo "📦 Adding files to git..."
git add .

# Commit
echo "💾 Creating commit..."
git commit -m "Deploy AI/ML Portfolio to GitHub Pages

Features:
- Auto-updating project summaries using Gemini AI
- Dynamic skills aggregation from projects
- Real-time GitHub commit tracking
- Responsive modern design
- Automatic deployment via GitHub Actions"

# Add remote
echo "🔗 Adding GitHub remote..."
git remote add origin https://github.com/Reberog/Reberog.github.io.git

# Set main branch
git branch -M main

# Push to GitHub
echo ""
echo "🚀 Ready to push to GitHub!"
echo ""
echo "⚠️  You will be prompted for credentials:"
echo "   Username: Reberog"
echo "   Password: Use your Personal Access Token"
echo ""
echo "   Get token at: https://github.com/settings/tokens"
echo "   Select scope: 'repo'"
echo ""

git push -u origin main

echo ""
echo "============================================"
echo "✅ SUCCESS! Your code is on GitHub!"
echo "============================================"
echo ""
echo "Next steps:"
echo "1. Go to: https://github.com/Reberog/Reberog.github.io/settings/pages"
echo "2. Under 'Build and deployment', set Source to 'GitHub Actions'"
echo "3. Go to Actions tab and watch the deployment"
echo "4. In 2-3 minutes, visit: https://reberog.github.io/"
echo ""
echo "🎉 Your portfolio will be LIVE!"
echo ""
