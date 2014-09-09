#!/usr/bin/awk -f

BEGINFILE {
	if (ARGIND < 2)
		nextfile
}

body == 0 {
	print
}

body == 1 {
	print | ARGV[1]
}

$0 == "--- body ---" {
	body = 1
}
