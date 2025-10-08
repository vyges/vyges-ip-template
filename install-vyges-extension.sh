#!/bin/bash

# Vyges Extension Installation Script
# Installs the bundled vycontext-0.1.0.vsix extension

set -e

echo "🚀 Installing Vyges VyContext Extension..."

# Detect IDE and install appropriate extension
if command -v cursor &> /dev/null; then
    echo "📦 Installing for Cursor IDE (bundled extension)..."
    CURSOR_EXTENSION="extensions/cursor/vycontext-0.1.0.vsix"
    if [ ! -f "$CURSOR_EXTENSION" ]; then
        echo "❌ Error: Cursor extension file not found at $CURSOR_EXTENSION"
        echo "   Make sure you're running this from the repository root"
        exit 1
    fi
    cursor --install-extension "$CURSOR_EXTENSION"
    echo "✅ Extension installed for Cursor IDE"
elif command -v code &> /dev/null; then
    echo "📦 Installing for VS Code (from marketplace)..."
    code --install-extension vyges.vycontext
    echo "✅ Extension installed for VS Code"
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
