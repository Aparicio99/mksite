#!/usr/bin/awk -f

@include "funcs.awk"
@include "generate_index.awk"
#@include "generate_tags.awk"

BEGIN {
	if (ARGC < 2) {
		print "Usage: ./parse_content.awk <file>"
		exit
	}

	filename = ARGV[1]

	switch (filename) {

		case /\.(md|markdown)$/:
			print_header_and_stop(filename)
			while (getline < filename)
				print | ENVIRON["MARKDOWN_PARSER"]
			break

		case /\.(sh|awk|py)$/:
			system(filename)
			break

		case /\.index$/:
			print read_file(filename)
			generate_index(filename)
			break

#		case /\.tags$/:
#			print read_file(filename)
#			generate_tags(filename)
#			break

		# Any file with an unknown extension is copied unchanged
		# But for convinience it should be .html
		default:
			while (getline < filename)
				print
			break
	}
}
