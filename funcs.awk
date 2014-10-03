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
	return file
}

function parse_post(filename, info) {

	delete info
	info["tags"][0] = "untagged"

	while(getline < filename && $0 != "--- body ---") {

		if ($1 == "title:")
			info["title"] = substr($0, 8)

		else if ($1 == "date:")
			info["date"] = substr($0, 7)

		else if ($1 == "draft:")
			info["draft"] = 1

		else if ($1 == "tags:")
			patsplit(substr($0, 7), info["tags"], "([^, ]+[^,]+[^, ]+)")
	}

	info["body"] = read_file(filename)
}

function strip_post_filename(file) {
	sub("^.*\\/", "", file)
	sub("\\..*$", "", file)
	return file
}
