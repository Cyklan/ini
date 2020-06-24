module ini

import os

pub fn serialize(ini_file map[string]map[string]string) string {
	mut s := ""
	for section in ini_file.keys() {
		s += "[$section]\n"
		for key in ini_file[section].keys() {
			x := ini_file[section][key]
			s += "$key=$x\n"
		}
	}

	return s
}

pub fn write(ini_file map[string]map[string]string, path string) {
	os.write_file(path, serialize(ini_file))
}