#!/usr/bin/awk -f

body == 0 {
	print
}

body == 1 {
	print | ENVIRON["STMD"]
}

$0 == "--- body ---" {
	body = 1
}
