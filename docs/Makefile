# Makefile
# Builds QUAD.nibble documentation

# Dependencies
# pandoc

# Path to markdown stylesheet
mdstyle := /assets/css/pandoc.css

.PHONY: pdf html

# Recursive wildcard
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

# Find all *.md files in
mdfiles := $(call rwildcard, ,*.md)

# Convert all *.md to *.pdf via LaTeX
pdf:
		@echo 'Transmuting markdown to PDF via Latex'
		@$(foreach f,$(mdfiles), \
			source=$(f); \
			destination=`echo "$(f)" | sed 's/.md/.pdf/'`; \
			echo Converting $$source to $$destination with pandoc; \
			touch $$destination; \
			pandoc --from markdown --to latex \
			-s -V geometry:margin=0.5in -o $$destination $$source; \
		)

# Convert all *.md to *.html
html:
		@echo 'Transmuting markdown to HTML'
		@$(foreach f,$(mdfiles), \
			source=$(f); \
			destination=`echo "$(f)" | sed 's/.md/.pdf/'`; \
			echo Converting $$source to $$destination with pandoc; \
			touch $$destination; \
			pandoc --from markdown --css $(mdstyle) --to html --standalone -o $$destination $$source; \
		)
