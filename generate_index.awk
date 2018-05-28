@load "filefuncs"

function generate_entry(path) {
	parse_post(path, post)

	if (post["draft"] || post["hide"])
		return

	url = strip_post_filename(path)

	printf("        <li>\n")
	printf("          <a href='PAGE(%s)'>%s</a>\n", url, post["title"])
	printf("          <span class='right smaller'>%s</span>\n", post["tags_string"])
	printf("        </li>\n")
}

# TODO: Melhorar a identação do HTML gerado

function indent(level,      i) {
	for (i = 0; i < level; i++)
		printf "  "
}

function find_index(data,      i) {
	for (i in data) {
		if (i ~ /^index\..*/)
			return i
	}
}

function traverse(data, level) {
	PROCINFO["sorted_in"] = "@ind_str_asc"
	for (i in data) {
		if (isarray(data[i])) {

			# Directory
			if ("." in data[i]) {

				# Don't print top level index file
				if (level > 0) {
					# Search for index files inside directory
					index_page = find_index(data[i])

					if (index_page)
						generate_entry(data[i][index_page]["path"])
					else
						print "<li>" i "</li>"
				}
				print "<ul class='sitemap'>"
				traverse(data[i], level + 1)
				print "</ul>"

			# File - Ignore hidden and index files
			} else if (i !~ /^\./ && i !~ /^index\..*/) {
				generate_entry(data[i]["path"])
			}
		}
	}
}

function generate_index(filename,      dir, path, result) {

	dir = filename
	# Remove file from path
	sub(/\/[^\/]+$/, "", dir)

	path[0] = dir
	result = fts(path, FTS_LOGICAL, filedata)
	print "<p><strong>Pages</strong><span class=\"right\"><strong>Tags</strong></span></p>"
	traverse(filedata, 0)
}
