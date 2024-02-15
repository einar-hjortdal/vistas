module main

import x.vweb
import os

// handle_delete_file deletes a file with the provided file_name.
// This function will delete compressed files with the same file_name.
// Query `dir`: when present or 'true', will delete directories recursively.
// Requires authorization. (TODO)
fn handle_delete_file(app &App, mut ctx Context, file_name string) vweb.Result {
	fn_name := 'handle_delete_file'

	is_directory := ctx.form['dir'] == '' || ctx.form['dir'] == 'true'

	file_path := '${app.public_directory}/${file_name}'
	if is_directory {
		os.rmdir(file_path) or { return ctx.send_error(err, fn_name) }
	}

	if could_gzip(file_name) {
		gzip_file_path := '${file_path}${gzip_extension}'
		os.rm(gzip_file_path) or {} // TODO log, maybe return report
	}

	os.rm(file_path) or { return ctx.send_error(err, fn_name) }
	return ctx.ok('OK')
}
