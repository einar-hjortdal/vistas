module main

import x.vweb
import net.http
import os

// handle_delete_file deletes a file with the provided file_name.
// This function will delete compressed files with the same file_name.
// Requires authorization. (TODO)
fn handle_delete_file(app &App, mut ctx Context, file_name string) vweb.Result {
	fn_name := 'handle_delete_file'

	file_path := os.join_path(app.public_directory, file_name)
	if !file_path.starts_with(app.public_directory) {
		error := new_vistas_error(http.Status.bad_request, 'Invalid path')
		return ctx.send_error(error, fn_name)
	}

	if could_gzip(file_name) {
		gzip_file_path := '${file_path}${gzip_extension}'
		os.rm(gzip_file_path) or {} // TODO log, maybe return report
	}

	os.rm(file_path) or { return ctx.send_error(err, fn_name) }
	return ctx.ok('OK')
}
