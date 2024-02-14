module main

import os

fn create_app_instance() !&App {
	env_mode := string_default_if_empty(os.getenv('MODE'), 'development')
	env_public_directory := string_default_if_empty(os.getenv('PUBLIC_DIRECTORY'), 'public')

	if env_mode != 'development' && env_mode != 'production' {
		return error('Environment variable `MODE` must be either `development` or `production`')
	}

	return &App{
		mode: string_default_if_empty(env_mode, 'development')
		public_directory: env_public_directory
	}
}

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
