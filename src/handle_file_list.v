module main

import x.vweb
import os
import net.http

// handle_list_files returns a list of files available to be served.
// Requires authorization. (TODO)
fn handle_list_files(app &App, mut ctx Context, directory string) vweb.Result {
	fn_name := 'handle_list_files'

	directory_path := os.join_path(app.public_directory, directory)
	if !directory_path.starts_with(app.public_directory) {
		error := new_vistas_error(http.Status.bad_request, 'Invalid path')
		return ctx.send_error(error, fn_name)
	}

	entries := os.ls(directory_path) or { return ctx.send_error(err, fn_name) }
	return ctx.json(entries)
}
