module main

import x.vweb
import os

// handle_list_files returns a list of files available to be served.
// Requires authorization. (TODO)
fn handle_list_files(app &App, mut ctx Context, directory string) vweb.Result {
	fn_name := 'handle_list_files'
	directory_path := '${app.public_directory}/${directory}'
	entries := os.ls(directory_path) or { return ctx.send_error(err, fn_name) }
	return ctx.json(entries)
}
