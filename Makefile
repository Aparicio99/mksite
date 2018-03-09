### Default directories

# Place for the final generated site files
export SITE = site

# Place for a dark theme version of the site
# Must be set in the config file to be generated
export SITE_DARK =

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
export BASE_URL_DARK = dark

export THEME = light
export OTHER_THEME = dark
export OTHER_THEME_URL = $(BASE_URL_DARK)

# Replace the defaults above inside this file
-include config.mk

.PHONY: all content light dark

.SILENT: # Do not print the commands

all: light dark

light: content
	echo "Generating site (light theme)"
	$(MAKE) -s -f main.mk

ifneq ($(SITE_DARK),)
dark: content
	echo "Generating site (dark theme)"
	$(MAKE) -s -f main.mk \
		SITE=$(SITE_DARK) \
		BASE_URL=$(BASE_URL_DARK) \
		THEME=dark \
		OTHER_THEME=light \
		OTHER_THEME_URL=$(BASE_URL)
endif

content:
	echo "Generating content"
	$(MAKE) -s -C $(CONTENT)

clean:
	$(MAKE) -s -C $(CONTENT) clean
	$(MAKE) -s -f main.mk clean
ifneq ($(SITE_DARK),)
	$(MAKE) -s -f main.mk clean SITE=$(SITE_DARK)
endif
