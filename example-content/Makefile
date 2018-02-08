
TARGETS = pages/tags/index.html # This should be the last target

all: $(TARGETS)

GREEN  = "[32m"
CYAN   = "[36m"
NORMAL = "[0m"

# Tag pages

pages/tags/index.html: $(shell find pages -type f -not -path "pages/tags/*")
	@echo "$(GREEN)[Generating content] $(CYAN)$@$(NORMAL)"
	@mkdir -p pages/tags
	@./generate_tags.awk $^

clean:
	$(RM) $(TARGETS) pages/tags/*
