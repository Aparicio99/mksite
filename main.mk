
TEMPLATE_FILES = $(wildcard $(TEMPLATE)/*.html) $(wildcard $(TEMPLATE)/*.awk)

FILES  = $(shell find $(FILES_DIR)/ -type f)
FILES2  = $(FILES:$(FILES_DIR)/%=%)

ALL_ORIGINAL = $(shell find $(PAGES_DIR)/ -type f -not -name ".*")
ALL_STRIPPED = $(ALL_ORIGINAL:$(PAGES_DIR)/%=%)
ALL_HTML     = $(basename $(ALL_STRIPPED))
ALL_HTML2    = $(addsuffix .html, $(ALL_HTML))

# Final generated files
SITE_HTML = $(addprefix $(SITE)/, $(ALL_HTML2))
SITEMAP   = $(SITE)/sitemap.html
INDEX     = $(SITE)/index.html
TAGS      = $(SITE)/tags
CSS       = $(addprefix $(SITE)/css/, $(notdir $(wildcard $(TEMPLATE)/css/*.css)))
IMAGES    = $(addprefix $(SITE)/images/, $(notdir $(wildcard $(TEMPLATE)/images/*)))
FILES3     = $(addprefix $(SITE)/files/, $(FILES2))

# Function to reverse a list
reverse = $(if $(1),$(call reverse,$(wordlist 2,$(words $(1)),$(1)))) $(firstword $(1))

export SITE MARKDOWN_PARSER TAGS EXT TMP_HTML PAGES_DIR

RED    = "[31m"
GREEN  = "[32m"
YELLOW = "[33m"
CYAN   = "[36m"
NORMAL = "[0m"

.PHONY: watch sitemap tags content

.SECONDARY:
all: $(CSS) $(INDEX) $(SITE_HTML) $(IMAGES) $(FILES3)

watch:
	inotifywait -rm . | awk '/MODIFY/{system("sleep 0.1 && make")}'

#tags: $(TAGS)

# Sitemap needs to depend on all pages, to be updated
# every time one page change or is added
$(TMP_HTML)/sitemap.html: $(ALL_ORIGINAL)

$(SITE)/css/molokai.css: $(TEMPLATE)/css/molokai.css
	@mkdir -p $(SITE)/css
	@echo "$(GREEN)[Minifying and mixing css] $(CYAN)$@$(NORMAL)"
	@./css_minifier.awk mix $< > $@

$(SITE)/css/%: $(TEMPLATE)/css/%
	@mkdir -p $(SITE)/css
	@echo "$(GREEN)[Minifying css] $(CYAN)$@$(NORMAL)"
	@./css_minifier.awk $< > $@

$(SITE)/images/%: $(TEMPLATE)/images/%
	@mkdir -p $(SITE)/images
	@echo "$(YELLOW)[Copy] $(CYAN)$@$(NORMAL)"
	@cp $< $@

$(SITE)/files/%: $(FILES_DIR)/%
	@mkdir -p $(dir $@)
	@echo "$(YELLOW)[Copy] $(CYAN)$@$(NORMAL)"
	@cp --force --link $< $@ || cp $< $@

$(SITE)/%.html: $(TMP_HTML)/%.html $(TEMPLATE_FILES)
	@mkdir -p $(SITE)/pages
	@mkdir -p "$(@D)"
	@echo "$(GREEN)[Generate page] $(CYAN)$@$(NORMAL)"
	@./generate_page.awk $< | m4 > $@

$(TMP_HTML)/%.html: $(PAGES_DIR)/%.*
	@mkdir -p $(TMP_HTML)
	@mkdir -p "$(@D)"
	@echo "$(RED)[Parse content] $(NORMAL)$<"
	@./parse_content.awk $< > $@

clean:
	rm -rf $(SITE)/*
	rm -rf $(TMP_HTML)
