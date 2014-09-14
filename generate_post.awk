#!/usr/bin/awk -f

@include "funcs.awk"

BEGIN {
	page_header = read_file(ENVIRON["HEADER"])
	page_footer = read_file(ENVIRON["FOOTER"])

	parse_post(ARGV[1], post)

	print header(page_header, post["title"])

	printf("<tt>%s</tt><br/>\n", post["date"])
	printf("%s\n", post["body"])


	if (post["tags"][0] != "untagged") {
		printf("<tt>tags: ")
		for (i in post["tags"]) {
			tag = post["tags"][i]
			if (i > 1)
				printf(",")
			printf("<a href=\"../tags/%s\">%s</a>", tag, tag)
		}
		printf("</tt>\n")
	}

	print page_footer
}
