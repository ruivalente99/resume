# Makefile for compiling LaTeX resume

# Default file to compile
FILE = resume

# Default target is all
all: $(FILE).pdf

# Compile tex to PDF using pdflatex
$(FILE).pdf: $(FILE).tex
	pdflatex -halt-on-error -interaction=nonstopmode $(FILE).tex

# Alternatively use latexmk for more complete compilation
latexmk: $(FILE).tex
	latexmk -pdf -halt-on-error -interaction=nonstopmode $(FILE).tex

# Clean up auxiliary files but keep the PDF
clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz *.dvi *.out.ps

# Clean everything including the PDF
distclean: clean
	rm -f $(FILE).pdf

# Setup git hooks
setup-hooks:
	./setup-hooks.sh

.PHONY: all clean distclean latexmk setup-hooks
