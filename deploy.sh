#!/bin/bash

# TridentFans Automated Deployment Script
echo "🚀 Starting TridentFans automated deployment..."

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    git branch -M main
fi

# Add all files
echo "📁 Adding files to git..."
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "Initial TridentFans deployment" || echo "No changes to commit"

# Check if GitHub CLI is available
if command -v gh &> /dev/null; then
    echo "🐙 Creating GitHub repository..."
    gh repo create tridentfans --public --source=. --remote=origin --push || {
        echo "Repository might already exist. Trying to push..."
        git remote add origin https://github.com/$(gh api user --jq .login)/tridentfans.git 2>/dev/null || true
        git push -u origin main
    }
    echo "✅ Repository created and code pushed!"
else
    echo "⚠️  GitHub CLI not found."
    echo "📥 Installing GitHub CLI..."
    
    # Try to install GitHub CLI based on OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install gh
        else
            echo "Please install Homebrew first: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh
    else
        echo "❌ Unsupported OS. Please install GitHub CLI manually:"
        echo "Visit: https://cli.github.com/"
        exit 1
    fi
    
    echo "🔐 Please authenticate with GitHub:"
    gh auth login
    
    echo "🐙 Creating GitHub repository..."
    gh repo create tridentfans --public --source=. --remote=origin --push
    echo "✅ Repository created and code pushed!"
fi

echo ""
echo "🎉 Deployment preparation complete!"
echo "📋 Next steps:"
echo "1. Visit: https://vercel.com/new"
echo "2. Import your GitHub repository: tridentfans"
echo "3. Add environment variables (see AUTOMATED_DEPLOYMENT.md)"
echo "4. Deploy!"