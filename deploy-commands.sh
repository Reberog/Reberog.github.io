#!/bin/bash
# Copy and paste these commands one by one into your Terminal

# Navigate to project
cd /Users/arpananand/Documents/Portfolio/portfolio-project

# Initialize git
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: AI/ML Portfolio with auto-skills system"

# Add remote
git remote add origin https://github.com/Reberog/Reberog.github.io.git

# Set main branch
git branch -M main

# Push to GitHub (you'll need to authenticate)
git push -u origin main

echo ""
echo "✅ Code pushed to GitHub!"
echo ""
echo "Next steps:"
echo "1. Go to https://github.com/Reberog/Reberog.github.io/settings/pages"
echo "2. Set Source to 'GitHub Actions'"
echo "3. Visit https://reberog.github.io/ in 2-3 minutes!"
