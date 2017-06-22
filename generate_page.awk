#!/usr/bin/gawk -f

function define(name , value) {
	print "define(`__" name "__', `" value "')dnl"
}

@include "funcs.awk"
@include "template/default.awk"
@include "template/clean.awk"
@include "template/blog.awk"
@include "template/index.awk"

BEGIN {
	parse_post(ARGV[1], post)

	title    = post["title"]
	template = post["template"]
	content  = post["body"]

	define("TITLE", title)
	define("TEMPLATE", template)
	define("EXT", ENVIRON["EXT"])
	define("TAGS_URL", tags_url())

	print read_file("template/header.html")

	hook_pre = hook_pre_content[template]
	@hook_pre()

	# Only run code highlither on pages that seem to have
	# at least one markdown generated code block, to speed
	# up the regenerating of all pages

	if (match(content, "<pre><code")) {
		print content | "./code_highlight.py"
		define("CODE_CSS", 1)
	} else {
		print content
	}

	hook_pos = hook_pos_content[template]
	@hook_pos()

	print read_file("template/footer.html")
}
