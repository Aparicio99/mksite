BEGIN {
	hook_pre_content["clean"] = "clean_hook_pre_content"
	hook_pos_content["clean"] = "default_hook_pos_content"
}

function clean_hook_pre_content() {
}
