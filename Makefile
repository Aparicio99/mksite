### Default directories

# Place for the final generated site files
export SITE = site

# The content to generate the site
export CONTENT = example-content

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
export SITE_NAME = Yet another site
export SITE_DESCRIPTION = Some description here

# Extension for the hosted files.
#  .html to work everywhere
#  empty to have clean URLs with mod_rewrite or similar
export EXT = .html
export BASE_URL =

# Replace the defaults above inside this file
-include config.mk

all:
	@echo "Generating content" >/dev/null
	@$(MAKE) -s -C $(CONTENT)

	@echo "Generating site" >/dev/null
	@$(MAKE) -s -f main.mk

clean:
	@$(MAKE) -s -C $(CONTENT) clean
	@$(MAKE) -s -f main.mk clean
