#!/usr/bin/gawk -f

# Simple CSS minifier
#  - No guarantees for corner cases.
#  - Not 100% optimal, but close enough
#  - mix option gives super-optimal compression by factoring equal blocks,
#    but this messues up the original order, and should only be used in stuff
#    like syntax highlighting styles

BEGIN {
	# Makes input be returned in its entirety as $0
	RS="dhDYWdRiC5qIDgp6VrC63OhKeJw"

	if (ARGC > 1 && ARGV[1] == "mix") {
		delete ARGV[1]
		mix = 1
	}
}

{
	# Remove '/' inside comments, probably.
	gsub(/[^\*]\/[^\*]/, "")

	# Remove comments
	gsub(/\/\*[^\/]*\*\//, "")

	# Remove whitespace around separating characters
	gsub(/[ \t]*:[ \t]*/, ":")
	gsub(/[ \t]*,[ \t]*/, ",")
	gsub(/[ \t\n]*;[ \t\n]*/, ";")
	gsub(/[ \t\n]*{[ \t\n]*/, "{")
	gsub(/[ \t\n]*}[ \t\n]*/, "}")

	# Remove semi-colons when before closing bracket
	gsub(/;}/, "}")

	# Remove remaining newlines
	gsub(/\n+/, "")

	# Compress RGB colors: #XXYYZZ -> #XYZ

	n = 0
	while (i = match($0, /#([[:xdigit:]]{6})/, result)) {

		# Break loop when starts to match again from the beginning
		if (i <= n)
			break
		n = i

		split(result[1], val, "")

		if (val[1] == val[2] &&
		    val[3] == val[4] &&
		    val[5] == val[6])
			gsub(result[0], "#" val[1] val[3] val[5]);
	}

	# Join selectors with equal declaration blocks

	if (mix) {
		patsplit($0, result, /{[^}]+}/, seps)

		for (i in result) {
			selectors = seps[i-1]
			block     = result[i]

			if (!line[block])
				line[block] = selectors
			else
				line[block] = line[block] "," selectors
		}

		for (i in line)
			printf line[i]i
		printf "\n"

	} else {
		print
	}
}
