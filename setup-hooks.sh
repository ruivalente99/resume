#!/bin/bash

# This script sets up the pre-commit hook to automatically generate a PDF from the LaTeX file

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Setting up the pre-commit hook for LaTeX PDF generation..."

# Check if .git directory exists
if [ ! -d ".git" ]; then
    echo -e "${RED}Error: This is not a git repository. Please run this script from the root of your git repository.${NC}"
    exit 1
fi

# Create hooks directory if it doesn't exist
if [ ! -d ".git/hooks" ]; then
    mkdir -p .git/hooks
fi

# Create the pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

# Store the name of the LaTeX file
TEX_FILE="resume.tex"
PDF_FILE="resume.pdf"

echo "Running pre-commit hook to generate PDF from LaTeX..."

# Check if the LaTeX file was changed
if git diff --cached --name-only | grep -q "$TEX_FILE"; then
    echo "Changes detected in $TEX_FILE, rebuilding PDF..."

    # Try to compile the LaTeX file
    # First attempt with pdflatex
    if command -v pdflatex &> /dev/null; then
        echo "Running pdflatex..."
        pdflatex -halt-on-error -interaction=nonstopmode "$TEX_FILE"
        if [ $? -ne 0 ]; then
            echo "Error: pdflatex compilation failed. Fix LaTeX errors before committing."
            exit 1
        fi
    # If pdflatex is not available, try latexmk
    elif command -v latexmk &> /dev/null; then
        echo "Running latexmk..."
        latexmk -pdf -halt-on-error -interaction=nonstopmode "$TEX_FILE"
        if [ $? -ne 0 ]; then
            echo "Error: latexmk compilation failed. Fix LaTeX errors before committing."
            exit 1
        fi
    else
        echo "Warning: Neither pdflatex nor latexmk are available. PDF not generated."
        exit 1
    fi

    # If PDF was successfully generated, add it to the commit
    if [ -f "$PDF_FILE" ]; then
        echo "PDF successfully generated. Adding to commit..."
        git add "$PDF_FILE"
    else
        echo "Error: PDF file not found after compilation. Check LaTeX output."
        exit 1
    fi
else
    echo "No changes to $TEX_FILE, skipping PDF generation."
fi

# Exit successfully
exit 0
EOF

# Make the hook executable
chmod +x .git/hooks/pre-commit

# Check if the hook was created successfully
if [ -x ".git/hooks/pre-commit" ]; then
    echo -e "${GREEN}Pre-commit hook successfully set up!${NC}"
    echo "Now whenever you commit changes to $TEX_FILE, the PDF will be automatically generated and added to your commit."
else
    echo -e "${RED}Failed to set up the pre-commit hook.${NC}"
    exit 1
fi
