#!/usr/bin/gawk -f

@include "funcs.awk"

$0 == "--- header ---" {

	parse_post(FILENAME, post)

	for (i in post["tags"]) {
		tag = post["tags"][i]
		tags[tag] += 1

		url = strip_post_filename(FILENAME)
		posts[tag][FILENAME] = sprintf("<tt>%s</tt> - <a href=\"../posts/%s\">%s</a><br/>",
				post["date"], url ENVIRON["EXT"], post["title"])
	}
}

END {
	page_header = read_file(ENVIRON["HEADER"])
	page_footer = read_file(ENVIRON["FOOTER"])

	out = ENVIRON["TAGS"] "/index.html"

	print header(page_header, "tags") > out

	PROCINFO["sorted_in"] = "@val_num_desc"
	for (tag in tags)
		printf("<a href=\"%s\">%s (%d)</a><br/>\n", tag ENVIRON["EXT"], tag, tags[tag]) > out

	print page_footer > out

	PROCINFO["sorted_in"] = "@ind_num_desc"
	for (tag in posts) {

		out = ENVIRON["TAGS"] "/"tag".html"

		print header(page_header, tag) > out

		for (file in posts[tag])
			print posts[tag][file] > out

		print page_footer > out
	}
}
