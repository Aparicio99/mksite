#!/usr/bin/gawk -f

function check_url(url) {
	# Do not use -I because some servers return "405 Method Not Allowed"
	cmd = "curl -si " url " 2>/dev/null"
	status = 0
	location = ""

	while (cmd | getline) {

		if (/^HTTP/)
			status = $2

		else if (/^Location:/)

			location = $2
		# Ignore the response after the header
		else if (NF <= 1)
			break
	}
	# ret >> 8 (same as ret % 255) because for some reason close returns the exit code
	# in the most significant byte of a 16bit value
	ret = rshift(close(cmd), 8)
	return status
}

/https?:\/\// {

	# TODO: Better URL regex
	match($0, "https?://[^\"'()\\[\\] ]+", a)
	url = a[0]

	if (url) {
		status = check_url(url)

		if (status == 200) # HTTP/1.1 200 OK
			next

		if (status == 999) # HTTP/1.1 999 Request denied -> Linkedin being weird
			next

		if (status == 0) {
			if (ret == 6)
				ret = "cannot resolve host"
			else if (ret == 60)
				ret = "cert problem"
		}

		printf "%3d (%s) %s %s => %s\n", status, ret, FILENAME, url, location

	} else {
		print  "WARNING: Could not find the URL: $0"
	}
}
