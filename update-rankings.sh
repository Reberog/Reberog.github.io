#!/bin/bash

# Quick command to analyze and update project rankings

echo "🤖 Analyzing GitHub projects with Gemini AI..."
echo ""

cd api

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found. Run ./setup-ranking.sh first"
    exit 1
fi

# Activate virtual environment
source venv/bin/activate

# Check for .env
if [ ! -f ".env" ]; then
    echo "❌ .env file not found. Please create it with your GEMINI_API_KEY"
    exit 1
fi

# Run analysis
python analyze_projects.py

if [ $? -eq 0 ]; then
    echo ""
    echo "📋 Copying rankings to public folder..."
    cp project_rankings.json ../public/api/
    
    echo "✅ Done! Refresh your browser to see updated rankings."
else
    echo "❌ Analysis failed. Check error messages above."
    exit 1
fi

cd ..
