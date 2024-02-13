module main

import os

fn create_public_directory(dirname string) {
	dirpath := '${os.getwd()}/${dirname}'
	if _ := os.stat(dirname) {
		if os.is_file(dirname) {
			panic('Cannot create public directory: ${dirpath} is a file')
		}
		if os.is_dir(dirname) {
			println('Files are served from the directory ${dirpath}')
		}
	} else {
		os.mkdir(dirname) or { panic(err) }
		println('Public directory ${dirpath} created successfully')
	}
}

fn setup(app App) {
	create_public_directory(app.public_directory)
}
