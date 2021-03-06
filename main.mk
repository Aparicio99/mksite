RED    = "[31m"
GREEN  = "[32m"
YELLOW = "[33m"
CYAN   = "[36m"
NORMAL = "[0m"

TEMPLATE_FILES = $(wildcard $(TEMPLATE)/*.html) $(wildcard $(TEMPLATE)/*.awk)

FILES  = $(shell find $(FILES_DIR)/ -type f -not -name "*~")
FILES2 = $(FILES:$(FILES_DIR)/%=%)

ALL_ORIGINAL = $(shell find $(PAGES_DIR)/ -type f -not -name ".*")
ALL_STRIPPED = $(ALL_ORIGINAL:$(PAGES_DIR)/%=%)
ALL_HTML     = $(basename $(ALL_STRIPPED))
ALL_HTML2    = $(addsuffix .html, $(ALL_HTML))

# Final generated files
SITE_HTML = $(addprefix $(SITE)/, $(ALL_HTML2))
SITEMAP   = $(SITE)/sitemap.html
INDEX     = $(SITE)/index.html
CSS       = $(addprefix $(SITE)/css/, main.css code.css print.css)
IMAGES    = $(addprefix $(SITE)/images/, $(notdir $(wildcard $(TEMPLATE)/images/*)))
FILES3    = $(addprefix $(SITE)/files/, $(FILES2))

# Function to reverse a list
reverse = $(if $(1),$(call reverse,$(wordlist 2,$(words $(1)),$(1)))) $(firstword $(1))

.PHONY: site clean watch

# Keep temp files to speedup dark version generation
.SECONDARY:

# Prevent anything from running if we are not called by the main Makefile
ifndef SITE
$(error SITE is not set)
endif

site: $(CSS) $(INDEX) $(SITE_HTML) $(IMAGES) $(FILES3)

# Sitemap needs to depend on all pages, to be updated
# every time one page changes or is added
$(TMP_HTML)/sitemap.html: $(ALL_ORIGINAL)

$(SITE)/css/code.css: $(TEMPLATE)/css/code.css
	mkdir -p $(SITE)/css
	echo "$(GREEN)[Minifying and mixing css] $(CYAN)$@$(NORMAL)"
	./css_minifier.awk mix $< > $@

$(SITE)/css/main.css: $(TEMPLATE)/css/$(THEME).css.m4 $(TEMPLATE)/css/main.css.m4
	mkdir -p $(SITE)/css
	echo "$(GREEN)[Generating and minifying css] $(CYAN)$@$(NORMAL)"
	m4 $^ | ./css_minifier.awk > $@

$(SITE)/css/%.css: $(TEMPLATE)/css/%.css
	mkdir -p $(SITE)/css
	echo "$(GREEN)[Minifying css] $(CYAN)$@$(NORMAL)"
	./css_minifier.awk $< > $@

$(SITE)/images/%: $(TEMPLATE)/images/%
	mkdir -p $(SITE)/images
	echo "$(YELLOW)[Copy] $(CYAN)$@$(NORMAL)"
	cp $< $@

$(SITE)/files/%: $(FILES_DIR)/%
	mkdir -p $(dir $@)
	echo "$(YELLOW)[Copy] $(CYAN)$@$(NORMAL)"
	cp --force --link $< $@ || cp $< $@

$(SITE)/%.html: $(TMP_HTML)/%.html $(TEMPLATE_FILES)
	mkdir -p "$(@D)"
	echo "$(GREEN)[Generate page] $(CYAN)$@$(NORMAL)"
	./generate_page.awk $< | m4 > $@

$(TMP_HTML)/%.html: $(PAGES_DIR)/%.*
	mkdir -p "$(@D)"
	echo "$(RED)[Parse content] $(NORMAL)$<"
	./parse_content.awk $< > $@

clean:
	$(RM) -r $(SITE)
	$(RM) -r $(TMP_HTML)

watch:
	inotifywait -rm . | awk '/MODIFY/{system("sleep 0.1 && make")}'

check_urls: $(ALL_ORIGINAL)
	./dead_link_checker.awk $^
