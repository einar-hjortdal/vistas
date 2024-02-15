module main

import compress.gzip
import os
import x.vweb

// handle_create_files creates files with the data contained in Multipart FormData.
// This function is designed to only process one file.
// The body of the request should contain the file.
// Query `gzip`: when present or 'true', the file will be compressed.
// Requires authorization. (TODO)
// TODO create directory when provided in file_name
fn handle_create_file(app &App, mut ctx Context, file_name string) vweb.Result {
	fn_name := 'handle_create_file'

	should_gzip := ctx.form['gzip'] == '' || ctx.form['gzip'] == 'true'

	file_path := '${app.public_directory}/${file_name}'
	mut file := os.create(file_path) or { return ctx.send_error(err, fn_name) }
	file.write(ctx.req.data.bytes()) or {
		file.close()
		return ctx.send_error(err, fn_name)
	}
	file.close()

	if should_gzip && could_gzip(file_name) {
		gzip_file_name := '${file_name}${gzip_extension}'
		gzip_file_path := '${app.public_directory}/${gzip_file_name}'
		gzip_file_data := gzip.compress(ctx.req.data.bytes()) or {
			os.rm(file_path) or { return ctx.send_error(err, fn_name) }
			return ctx.send_error(err, fn_name)
		}
		mut gzip_file := os.create(gzip_file_path) or { return ctx.send_error(err, fn_name) }
		gzip_file.write(gzip_file_data) or {
			gzip_file.close()
			os.rm(file_path) or { return ctx.send_error(err, fn_name) }
			return ctx.send_error(err, fn_name)
		}
		gzip_file.close()
	}

	return ctx.ok('OK')
}
