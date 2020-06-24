import ini
import os

fn test_write() {
	mut x := map[string]map[string]string
	x["foo"] = map[string]string
	x["foo"]["bar"] = "5"

	ini.write(x, "./serialize_test.ini")

	assert os.exists("./serialize_test.ini") == true
}

fn testsuite_end() {
	os.rm("./serialize_test.ini")
}