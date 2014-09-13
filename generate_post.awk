#!/usr/bin/awk -f

@include "funcs.awk"

BEGIN {
	page_header = read_file(ENVIRON["HEADER"])
	page_footer = read_file(ENVIRON["FOOTER"])

	parse_post(ARGV[1], post)

	print header(page_header, post["title"])

	printf("<tt>%s</tt><br/>\n", post["date"])
	printf("%s\n", post["body"])

	if (post["tags"] != "untagged")
		printf("<tt>tags: %s</tt>\n", post["tags"])

	print page_footer
}
