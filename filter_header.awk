#!/usr/bin/awk -f


header == 0 && $0 == "--- header ---" {
	header = 1
	title = date = body = ""
}

header == 1 && $1 == "title:" {
	title = substr($0, 8)
}

header == 1 && $1 == "date:" {
	date = substr($0, 7)
}

$0 == "--- body ---" {
	header = 0
	next
}

header == 0 {
	if (body)
		body = body "\n<br/>" $0
	else
		body = $0
}

ENDFILE {
	printf("<h3 id="hn_Title">%s</h3>\n", title)
	printf("<tt>%s</tt><br/>\n", date)
	printf("%s\n", body)
}
