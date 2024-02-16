module main

import os

fn create_app_instance() !&App {
	env_mode := string_default_if_empty(os.getenv('MODE'), 'development')
	env_public_directory := string_default_if_empty(os.getenv('PUBLIC_DIRECTORY'), 'public')

	public_directory_abs_path := os.abs_path(env_public_directory)

	if env_mode != 'development' && env_mode != 'production' {
		return error('Environment variable `MODE` must be either `development` or `production`')
	}

	return &App{
		mode: string_default_if_empty(env_mode, 'development')
		public_directory: public_directory_abs_path
	}
}

fn create_public_directory(dir_path string) {
	if _ := os.stat(dir_path) {
		if os.is_file(dir_path) {
			panic('Cannot create public directory: ${dir_path} is a file')
		}
		if os.is_dir(dir_path) {
			println('Files are served from the directory ${dir_path}')
		}
	} else {
		os.mkdir(dir_path) or { panic(err) }
		println('Public directory ${dir_path} created successfully')
	}
}

fn setup(app App) {
	create_public_directory(app.public_directory)
}
