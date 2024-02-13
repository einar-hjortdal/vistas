module main

import os

fn create_public_directory(dirname string) {
	if _ := os.stat(dirname) {
		if os.is_file(dirname) {
			panic('Cannot create public directory: ${os.getwd()}/${dirname} is a file.')
		}
		if os.is_dir(dirname) {
			println('Files are served from the directory ${os.getwd()}/${dirname}.')
		}
	} else {
		os.mkdir(dirname) or { panic(err) }
		println('Public directory ${os.getwd()}/${dirname} successfully created.')
	}
}

fn setup() {
	dirname := 'public'
	create_public_directory(dirname)
}
