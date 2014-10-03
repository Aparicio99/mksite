#!/usr/bin/awk -f

@include "funcs.awk"

BEGIN {
	page_header = read_file(ENVIRON["HEADER"])
	page_footer = read_file(ENVIRON["FOOTER"])

	print header(page_header, "start")
}

$0 == "--- header ---" {

	parse_post(FILENAME, post)

	if (post["draft"])
		next

	url = strip_post_filename(FILENAME)

	printf("<h3 id=\"hn_Title\"><a href=\"posts/%s\">%s</a></h3>\n", url ENVIRON["EXT"], post["title"])
	printf("<tt>%s</tt><br/>\n", post["date"])
	printf("%s\n<hr><br/><br/>", post["body"])
}

END {
	print page_footer
}
