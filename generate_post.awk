#!/usr/bin/awk -f

BEGIN {
	# Read HTML header
	while(getline < ARGV[1]) {

		if (page_header)
			page_header = page_header "\n" $0
		else
			page_header = $0
	}

	# Read post details
	while((getline < ARGV[2]) && $0 != "--- body ---") {

		if ($1 == "title:")
			title = substr($0, 8)

		else if ($1 == "date:")
			date = substr($0, 7)
	}

	# Read post body
	while(getline < ARGV[2]) {

		if (page_body)
			page_body = page_body "\n" $0
		else
			page_body = $0
	}

	# Print HTML header after replacing things
	gsub("\\$\\$TITLE\\$\\$", title, page_header)
	print page_header

	# Print HTML post body
	printf("<tt>%s</tt><br/>\n", date)
	printf("%s\n", page_body)

	# Print HTML footer
	while(getline < ARGV[3])
		print
}
