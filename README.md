# LaTeX Resume

A professional resume created with LaTeX. The repository includes a GitHub Actions workflow that automatically compiles the LaTeX file into a PDF whenever changes are pushed to the main branch.

## Features

- Clean, professional LaTeX template
- Automated PDF generation via GitHub Actions
- Syntax validation and linting before PDF compilation
- PDF artifacts available for download from GitHub Actions runs

## Workflow

The GitHub Actions workflow does the following:

1. **Validates** the LaTeX file for syntax errors and performs linting
2. **Compiles** the LaTeX file into a PDF
3. **Uploads** the generated PDF as an artifact
4. **Commits** the updated PDF back to the repository

## Local Development

### Prerequisites

- LaTeX distribution (e.g., TeX Live, MiKTeX)
- LaTeX editor (optional)

### Compiling Locally

```bash
# Compile the LaTeX file to PDF
pdflatex resume.tex

# Or using latexmk for more comprehensive compilation
latexmk -pdf resume.tex
```

## Structure

- `resume.tex` - Source LaTeX file
- `resume.pdf` - Compiled PDF output
- `.github/workflows/compile-latex.yml` - GitHub Actions workflow configuration

## Last Updated

May 20, 2025
