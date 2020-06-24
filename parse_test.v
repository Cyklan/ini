import ini
import os

fn test_open() {
	opened := ini.open("./test.ini") or {
		println(err)
		return
	}
	assert opened.keys().len == 2
	assert opened.keys()[0] == "foo"
	assert opened.keys()[1] == "bar"
	assert opened["foo"].keys().len == 1
	assert opened["foo"]["x"] == "5"
	assert opened["bar"].keys().len == 2
	assert opened["bar"]["tom"] == "cat"
	assert opened["bar"]["jerry"] == "mouse"

}

fn test_parse() {
	file_text := os.read_file("./test.ini") or {
		println(err)
		return
	}

	parsed := ini.parse(file_text)
	assert parsed.keys().len == 2
	assert parsed.keys()[0] == "foo"
	assert parsed.keys()[1] == "bar"
	assert parsed["foo"].keys().len == 1
	assert parsed["foo"]["x"] == "5"
	assert parsed["bar"].keys().len == 2
	assert parsed["bar"]["tom"] == "cat"
	assert parsed["bar"]["jerry"] == "mouse"
}