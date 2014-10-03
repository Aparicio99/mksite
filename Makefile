
# Settings
SITE     = /home/aparicio/aparicio.pt_site/mount/public_html/blog
POSTS    = posts
TEMPLATE = template
TMP_HTML = tmp_html
STMD     = stmd/stmd
INDEX_NPOSTS = 5

# Extension for the hosted files.
#  .html to work everywhere
#  empty to have clean URLs with mod_rewrite or similar
EXT =

# Original files
HEADER  = $(TEMPLATE)/header.html
FOOTER  = $(TEMPLATE)/footer.html
CONTENT = $(call reverse, $(sort $(wildcard $(POSTS)/*.markdown)))

# Temporary files
POSTS_HTML = $(addprefix $(TMP_HTML)/, $(notdir $(CONTENT:%.markdown=%.html)))

# Final generated files
ARCHIVE   = $(SITE)/archive.html
INDEX     = $(SITE)/index.html
TAGS      = $(SITE)/tags/index.html
SITE_HTML = $(addprefix $(SITE)/posts/, $(notdir $(CONTENT:%.markdown=%.html)))
CSS       = $(addprefix $(SITE)/css/, $(notdir $(wildcard $(TEMPLATE)/css/*.css)))
IMAGES    = $(addprefix $(SITE)/images/, $(notdir $(wildcard $(TEMPLATE)/images/*)))

# Function to reverse a list
reverse = $(if $(1),$(call reverse,$(wordlist 2,$(words $(1)),$(1)))) $(firstword $(1))

export STMD HEADER FOOTER TAGS EXT

all: $(INDEX) $(SITE_HTML) $(ARCHIVE) $(TAGS) $(CSS) $(IMAGES)

$(SITE)/css/%: $(TEMPLATE)/css/%
	@mkdir -p $(SITE)/css
	cp $< $@

$(SITE)/images/%: $(TEMPLATE)/images/%
	@mkdir -p $(SITE)/images
	cp $< $@

$(INDEX): $(wordlist 1, $(INDEX_NPOSTS), $(POSTS_HTML))
	./generate_index.awk $+ > $@

$(ARCHIVE): $(CONTENT)
	./generate_archive.awk $+ > $@

$(TAGS): $(CONTENT)
	@mkdir -p $(TAGS)
	./generate_tags.awk $+

$(SITE)/posts/%.html: $(TMP_HTML)/%.html
	@mkdir -p $(SITE)/posts
	./generate_post.awk $+ > $@

$(TMP_HTML)/%.html: $(POSTS)/%.markdown
	@mkdir -p $(TMP_HTML)
	./parse_markdown.awk $+ > $@

clean:
	rm -rf $(SITE)/*
	rm -rf $(TMP_HTML)
