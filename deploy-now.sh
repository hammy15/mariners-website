#!/bin/bash

echo "🚀 DEPLOYING YOUR MARINERS APP..."
echo "=================================="

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build the app
echo "🔨 Building your app..."
npm run build

echo "✅ BUILD COMPLETE!"
echo ""
echo "🌐 DEPLOYMENT OPTIONS:"
echo "1. NETLIFY (Easiest):"
echo "   - Go to netlify.com"
echo "   - Drag the 'dist' folder to deploy"
echo ""
echo "2. SURGE (One command):"
echo "   - Run: npm install -g surge"
echo "   - Run: surge dist"
echo ""
echo "📁 Your built app is in the 'dist' folder"
echo "🎉 Ready to deploy!"