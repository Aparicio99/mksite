function header(page, title) {
	gsub("\\$\\$TITLE\\$\\$", title, page)
	gsub("\\$\\$EXT\\$\\$", ENVIRON["EXT"], page)
	return page
}

function read_file(filename) {
	file = ""
	while(getline < filename) {
		if (file)
			file = file "\n" $0
		else
			file = $0
	}
	close(filename)
	return file
}

function parse_post(filename, info,     i) {

	delete info
	info["tags"][0] = "untagged"
	info["template"] = "default"
	info["filename"] = filename
	info["path"] = strip_post_filename(filename)

	FS=":"

	while(getline < filename && $0 != "--- body ---") {

		# Trim whitespace
		sub(/[ \t]+$/, "", $2);
		sub(/^[ \t]+/, "", $2);

		if ($1 == "tags")
			patsplit($2, info["tags"], "([^, ]+[^,]+[^, ]+)")
		else
			info[$1] = $2
	}
	FS=" "

	tags_string = ""
	if (info["tags"][0] != "untagged") {
		for (i in info["tags"]) {
			tag = info["tags"][i]
			if (!tag)
				continue
			if (i > 1)
				tags_string = tags_string ", "
			tags_string = tags_string sprintf("<a href=\"LINK(tags/%s)\">%s</a>", tag, tag)
		}
	}

	info["tags_string"] = tags_string
	info["body"] = read_file(filename)
}

function print_header_and_stop(filename) {
	while (getline < filename) {
		print
		if ($0 == "--- body ---")
			break
	}
}

function strip_post_filename(file) {
	sub("^"ENVIRON["PAGES_DIR"]"/", "", file)
	sub("^"ENVIRON["TMP_HTML"]"/", "", file)
	sub("\\..*$", "", file)
	return file
}
