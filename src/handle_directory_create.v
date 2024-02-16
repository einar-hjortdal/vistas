module main

import x.vweb
import os
import net.http

// handle_create_directory creates a new directory with the provided directory_name.
fn handle_create_directory(app &App, mut ctx Context, directory_name string) vweb.Result {
	fn_name := 'handle_create_directory'
	directory_path := os.join_path(app.public_directory, directory_name)
	if !directory_path.starts_with(app.public_directory) {
		error := new_vistas_error(http.Status.bad_request, 'Invalid path')
		return ctx.send_error(error, fn_name)
	}

	os.mkdir(directory_path) or { return ctx.send_error(err, fn_name) }
	return ctx.ok('OK')
}
