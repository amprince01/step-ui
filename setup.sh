#!/bin/bash

# Step-CA Web UI Setup Script

set -e

echo "🚀 Setting up Step-CA Web UI..."
echo "📦 Repository: https://github.com/marcin-kruszynski/step-ui.git"

# Check if Docker is installed
if ! command -v podman &> /dev/null; then
    echo "❌ Podman is not installed. Please install Podman first."
    exit 1
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p data

# Copy environment file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cp example.env .env
    echo "✅ Created .env file. Please edit it with your Step-CA configuration."
else
    echo "✅ .env file already exists."
fi

# Load environment variables from .env file
if [ -f .env ]; then
    echo "📄 Loading environment variables from .env file..."
    export $(grep -v '^#' .env | xargs)
fi

# Check environment configuration
echo "🔐 Checking configuration..."
if [ -z "$CA_URL" ]; then
    echo "⚠️  CA_URL not set in .env file. Please configure your Step-CA URL."
fi

if [ -z "$PROVISIONER_PASSWORD" ]; then
    echo "⚠️  PROVISIONER_PASSWORD not set in .env file. Please configure your provisioner password."
fi

# Build and start services
echo "🔨 Building and starting services..."
docker compose up -d --build

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Edit .env file with your Step-CA configuration"
echo "2. Restart services: docker compose restart"
echo ""
echo "🌐 Access the application:"
echo "   Frontend: http://localhost:3000"
echo "   Backend API: http://localhost:8080"
echo ""
echo "📖 For more information, see README.md"
