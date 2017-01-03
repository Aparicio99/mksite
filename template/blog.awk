BEGIN {
	hook_pre_content["blog"] = "blog_hook_pre_content"
	hook_pos_content["blog"] = "default_hook_pos_content"
}

function blog_hook_pre_content() {
	printf("<code>%s</code>\n<h1>%s</h1>\n", post["date"], post["title"])
}
