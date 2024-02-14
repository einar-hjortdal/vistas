module main

import x.vweb
import net.http
import os

// handle_get_file serves the requested file, only in development.
fn handle_get_file(app &App, mut ctx Context, file_name string) vweb.Result {
	if app.mode == 'production' {
		return ctx.request_error("You're running vistas in production mode. Your files should be served by your web server (eg. Apache httpd)")
	}

	file_path := '${app.public_directory}/${file_name}'

	if accepted_encoding := ctx.get_header(http.CommonHeader.accept_encoding) {
		if accepted_encoding.contains('gzip') {
			if file_extension := may_be_compressed(file_name) {
				compressed_file_path := '${file_path}${gzip_extension}'
				if os.is_file(compressed_file_path) {
					content_type := get_content_type(file_extension)
					ctx.set_header(http.CommonHeader.content_encoding, 'gzip')
					ctx.set_header(http.CommonHeader.vary, 'Accept-Encoding')
					ctx.set_content_type(content_type)
					return ctx.file(compressed_file_path)
				}
			}
		}
	}

	if os.is_file(file_path) {
		return ctx.file(file_path)
	}
	return ctx.not_found()
}

// handle_list_files returns a list of files available to be served.
// Requires authorization. (TODO)
fn handle_list_files(app &App, mut ctx Context) vweb.Result {
	entries := os.ls(app.public_directory) or { [] }
	return ctx.json(entries)
}

// handle_create_file creates a file in app.public_directory.
// If requested, and if it makes sense to do so, a .gz file is also created.
// Requires authorization. (TODO)
fn handle_create_file(app &App, mut ctx Context) vweb.Result {
	return ctx.ok('OK')
}
