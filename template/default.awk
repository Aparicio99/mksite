BEGIN {
	hook_pre_content["default"] = "default_hook_pre_content"
	hook_pos_content["default"] = "default_hook_pos_content"
}

function default_hook_pre_content() {
	if (post["tags_string"] != "")
		left_footer = "tags: " post["tags_string"]
	else
		left_footer = ""

	custom_link = "<a href=\"__HOMEPAGE__\">home</a> |"

	define("LEFT_FOOTER", left_footer)
	define("CUSTOM_LINK", custom_link)

	printf("<h1>%s</h1>\n", post["title"])
}

function default_hook_pos_content() {

}
