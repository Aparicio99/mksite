#!/usr/bin/awk -f

@include "funcs.awk"

BEGIN {
	page_header = read_file(ENVIRON["HEADER"])
	page_footer = read_file(ENVIRON["FOOTER"])

	print header(page_header, "archive")
}

$0 == "--- header ---" {

	parse_post(FILENAME, post)

	if (post["draft"])
		next

	url = strip_post_filename(FILENAME)
	printf("<tt>%s</tt> - <a href=\"posts/%s\">%s</a><br/>\n", post["date"], url ENVIRON["EXT"], post["title"])
}

END {
	print page_footer
}
