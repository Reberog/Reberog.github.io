#!/bin/bash

# Setup script for AI-powered project ranking system

echo "🚀 Setting up AI-Powered GitHub Project Ranking System"
echo "======================================================"
echo ""

# Check if we're in the right directory
if [ ! -d "api" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed"
    echo "Please install Python 3.8+ from https://www.python.org/"
    exit 1
fi

echo "✅ Python 3 found: $(python3 --version)"
echo ""

# Create virtual environment
echo "📦 Creating Python virtual environment..."
cd api
python3 -m venv venv

# Activate virtual environment
echo "🔄 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📥 Installing dependencies..."
pip install -q --upgrade pip
pip install -q -r requirements.txt

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

# Check for .env file
if [ ! -f ".env" ]; then
    echo ""
    echo "⚙️  Creating .env file..."
    cp .env.example .env
    echo "⚠️  IMPORTANT: Please edit api/.env and add your GEMINI_API_KEY"
    echo "   Get your free API key at: https://makersuite.google.com/app/apikey"
    echo ""
    echo "After adding your API key, run:"
    echo "  cd api"
    echo "  source venv/bin/activate"
    echo "  python analyze_projects.py"
else
    echo "✅ .env file already exists"
fi

cd ..

echo ""
echo "======================================================"
echo "✨ Setup complete!"
echo "======================================================"
echo ""
echo "Next steps:"
echo "1. Add your GEMINI_API_KEY to api/.env"
echo "2. Run: cd api && source venv/bin/activate"
echo "3. Run: python analyze_projects.py"
echo "4. Copy results: cp project_rankings.json ../public/api/"
echo "5. Refresh your portfolio to see ranked projects!"
echo ""
