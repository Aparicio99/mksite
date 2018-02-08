#!/usr/bin/gawk -f

@include "../funcs.awk"

function build_header(title) {
	return sprintf( "--- header ---\n" \
	             "title: %s\n" \
	             "hide: true\n" \
	             "--- body ---\n", title)
}

$0 == "--- header ---" {

	parse_post(FILENAME, post)

	if (post["draft"] || post["hide"])
		next

	for (i in post["tags"]) {
		tag = post["tags"][i]
		if (!tag)
			continue
		tags[tag] += 1

		url = FILENAME
		sub("^pages", "", url)
		sub("\\..*$", "", url)
		sub("^/", "", url)
		posts[tag][FILENAME] = sprintf("<li><a href=\"LINK(%s)\">%s</a></li>",
				url, post["title"])
	}
}

END {
	out = "pages/tags/index.html"
	print build_header("Tags") > out

	print "<ul>" > out

	PROCINFO["sorted_in"] = "@val_num_desc"
	for (tag in tags)
		printf("<li><a href=\"RELLINK(%s)\">%s (%d)</a></li>\n", tag, tag, tags[tag]) > out

	print "</ul>" > out

	PROCINFO["sorted_in"] = "@ind_num_desc"
	for (tag in posts) {

		out = "pages/tags/"tag".html"

		print build_header("Tag " tag) > out

		print "<ul>" > out

		for (file in posts[tag])
			print posts[tag][file] > out

		print "</ul>" > out
	}
}
