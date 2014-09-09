
# Settings
SITE = /home/aparicio/aparicio.pt_site/mount/public_html/blog2
POSTS = posts
TEMPLATE = template
TMP_HTML = tmp_html
INDEX_NPOSTS = 5
STMD=stmd/stmd

# Original files
HEADER = $(TEMPLATE)/header.html
FOOTER = $(TEMPLATE)/footer.html
CONTENT = $(call reverse, $(sort $(wildcard $(POSTS)/*.markdown)))

# Temporary files
POSTS_HTML = $(addprefix $(TMP_HTML)/, $(notdir $(CONTENT:%.markdown=%.html)))

# Final generated files
ARCHIVE = $(SITE)/archive.html
INDEX = $(SITE)/index.html
SITE_HTML = $(addprefix $(SITE)/, $(notdir $(CONTENT:%.markdown=%.html)))
CSS = $(addprefix $(SITE)/css/, $(notdir $(wildcard $(TEMPLATE)/css/*.css)))
IMAGES = $(addprefix $(SITE)/images/, $(notdir $(wildcard $(TEMPLATE)/images/*)))

# Function to reverse a list
reverse = $(if $(1),$(call reverse,$(wordlist 2,$(words $(1)),$(1)))) $(firstword $(1))

all: $(CSS) $(IMAGES) $(SITE_HTML) $(INDEX) $(ARCHIVE)

$(SITE)/css/%: $(TEMPLATE)/css/%
	@mkdir -p $(SITE)/css
	cp $< $@

$(SITE)/images/%: $(TEMPLATE)/images/%
	@mkdir -p $(SITE)/images
	cp $< $@

$(ARCHIVE): $(HEADER) $(FOOTER) $(POSTS_HTML)
	./generate_list.awk $+ > $@

$(INDEX): $(HEADER) $(FOOTER) $(wordlist 1, $(INDEX_NPOSTS), $(POSTS_HTML))
	./generate_index.awk $+ > $@

$(SITE)/%.html: $(HEADER) $(TMP_HTML)/%.html $(FOOTER)
	./generate_post.awk $+ > $@

$(TMP_HTML)/%.html: $(POSTS)/%.markdown
	@mkdir -p $(TMP_HTML)
	./parse_markdown.awk $(STMD) $+ > $@

clean:
	rm -rf $(SITE)/*
	rm -rf $(TMP_HTML)
