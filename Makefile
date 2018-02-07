### Default directories

# Place for the final generated site files
export SITE = site

# The content to generate the site
export CONTENT = content

# Source to generate the HTML pages
export PAGES_DIR = $(CONTENT)/pages

# Static files to copy unmodified
export FILES_DIR = $(CONTENT)/files

# The template to style the pages
export TEMPLATE = template

# Where to save temporary files
export TMP_HTML = tmp_html

### Other defaults
export MARKDOWN_PARSER = cmark

# Extension for the hosted files.
#  .html to work everywhere
#  empty to have clean URLs with mod_rewrite or similar
export EXT = .html
export BASE_URL =

# Replace the defaults above inside this file
-include config.mk

all:
	@echo "Generating content"
	@$(MAKE) -s -C content

	@echo "Generating site"
	@$(MAKE) -s -f main.mk

clean:
	@$(MAKE) -s -C content clean
	@$(MAKE) -s -f main.mk clean
