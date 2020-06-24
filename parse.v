module ini

import regex
import os

pub fn parse(content string) map[string]map[string]string {
	mut ini_file := map[string]map[string]string
	
	parseable_content := content.replace("\r", "")
	lines := parseable_content.split("\n")

	if lines.len == 0 {
		return ini_file
	}

	mut reg_comment, reg_pos, reg_err := regex.regex(r"^\s*[;#]")
	mut current_section := ""
	for line in lines {
		mut clean_line := line.trim("")
		if clean_line.len == 0 {
			continue
		}

		comment_start, comment_end := reg_comment.find(clean_line)
		if comment_start != -1 {
			continue
		}


		if clean_line.starts_with("[") && clean_line.ends_with("]") {
			clean_line = clean_line.trim_left("[").trim_right("]")
			current_section = clean_line
			ini_file[clean_line] = map[string]string
			continue
		}
		
		mut entry := line.split("=")

		key := entry[0]
		entry.delete(0)
		value := entry.join("=")

		ini_file[current_section][key] = value

	}

	return ini_file
}

pub fn open(path string) ?map[string]map[string]string {
	if !os.exists(path) {
		return error("File $path does not exist.")
	}

	x := os.read_file(path) or {
		return error(err)
	}
	return parse(x)
}

