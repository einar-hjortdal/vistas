module main

import x.vweb
import os
import net.http

// handle_delete_directory deletes a directory with the provided directory_name.
// Query `recursive`: when present or 'true', non-empty directories will be deleted.
// Requires authorization. (TODO)
fn handle_delete_directory(app &App, mut ctx Context, directory_name string) vweb.Result {
	fn_name := 'handle_delete_file'

	is_recursive := 'recursive' in ctx.query || ctx.query['recursive'] == 'true'

	directory_path := os.join_path(app.public_directory, directory_name)
	if !directory_path.starts_with(app.public_directory) {
		error := new_vistas_error(http.Status.bad_request, 'Invalid path')
		return ctx.send_error(error, fn_name)
	}

	if is_recursive {
		os.rmdir_all(directory_path) or { return ctx.send_error(err, fn_name) }
		return ctx.ok('OK')
	}
	os.rmdir(directory_path) or { return ctx.send_error(err, fn_name) }
	return ctx.ok('OK')
}
