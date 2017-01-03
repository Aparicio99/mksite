# Settings
export SITE      = site
export CONTENT   = content
export PAGES_DIR = $(CONTENT)/pages
export FILES_DIR = $(CONTENT)/files
export TEMPLATE  = template
export TMP_HTML  = tmp_html
export MARKDOWN_PARSER = cmark
export INDEX_NPOSTS = 5

# Extension for the hosted files.
#  .html to work everywhere
#  empty to have clean URLs with mod_rewrite or similar
export EXT = .html

-include config.mk

all:
	@echo "Generating content"
	@$(MAKE) -s -C content
	@echo "Generating site"
	@$(MAKE) -s -f main.mk

clean:
	@$(MAKE) -s -C content clean
	@$(MAKE) -s -f main.mk clean
