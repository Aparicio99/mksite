#!/usr/bin/awk -f

BEGIN {
	PAGE_TITLE = "archive"

	# Read HTML header
	while(getline < ARGV[1]) {

		if (page_header)
			page_header = page_header "\n" $0
		else
			page_header = $0
	}

	# Print HTML header after replacing things
	gsub("\\$\\$TITLE\\$\\$", PAGE_TITLE, page_header)
	print page_header

	# Print HTML footer
	while(getline < ARGV[2]) {

		if (page_footer)
			page_footer = page_footer "\n" $0
		else
			page_footer = $0
	}
}

BEGINFILE {
	if (ARGIND <= 2)
		nextfile
}

$0 == "--- header ---" {
	if (ARGIND > 2) {

		# Read post details
		while(getline < FILENAME && $0 != "--- body ---") {

			if ($1 == "title:")
				title = substr($0, 8)

			else if ($1 == "date:")
				date = substr($0, 7)
		}

		# Read post body
		page_body = ""
		while(getline < FILENAME) {

			if (page_body)
				page_body = page_body "\n<br/>" $0
			else
				page_body = $0
		}

		url = FILENAME
		sub(".txt$", ".html", url)
		sub(".*/", "", url)
		printf("<tt>%s</tt> - <a href=%s>%s</a><br/>\n", date, url, title)
	}
}

END {
	print page_footer
}
