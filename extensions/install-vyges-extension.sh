#!/bin/bash

# Vyges Extension Installation Script
# Installs the VyContext extension from marketplace

set -e

echo "🚀 Installing Vyges VyContext Extension..."

# Detect IDE and install appropriate extension
if command -v cursor &> /dev/null; then
    echo "📦 Installing for Cursor IDE (from Open VSX Registry)..."
    # Try Open VSX CLI first, fallback to Cursor CLI
    if command -v ovsx &> /dev/null; then
        ovsx install vyges.vycontext
    else
        cursor --install-extension vyges.vycontext
    fi
    echo "✅ Extension installed for Cursor IDE"
    echo "   Extension URL: https://open-vsx.org/extension/vyges/vycontext"
elif command -v code &> /dev/null; then
    echo "📦 Installing for VS Code (from VS Code Marketplace)..."
    code --install-extension vyges.vycontext
    echo "✅ Extension installed for VS Code"
    echo "   Extension URL: https://marketplace.visualstudio.com/items?itemName=vyges.vycontext"
else
    echo "❌ Error: Neither Cursor nor VS Code found in PATH"
    echo "   Please install Cursor (cursor.sh) or VS Code first"
    exit 1
fi

echo ""
echo "🎯 Next Steps:"
echo "   1. Restart your IDE"
echo "   2. Check extension status: Ctrl+Shift+P → 'Vyges VyContext: Show Status'"
echo "   3. Authenticate if prompted"
echo ""
echo "✨ Happy coding with Vyges AI Context!"
