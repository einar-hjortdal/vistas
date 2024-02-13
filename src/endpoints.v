module main

@['/file/:file_name'; get]
fn (app App) get_file(mut ctx Context, file_name string) {
	// file_name
}

@['/file/:file_name'; delete]
fn (app App) delete_file(mut ctx Context, file_name string) {
	// delete all files with file_name
}

@['/files'; get]
fn (app App) list_files(mut ctx Context) {
	// provide list of existing files
}

@['/files'; post]
fn (app App) create_file(mut ctx Context) {
	// create a file, return file_name
}

@['/auth'; post]
fn (app App) auth_user(mut ctx Context) {
	// authenticate
}
