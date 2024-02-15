module main

import net.http
import compress.gzip
import os
import x.vweb

// handle_create_files creates files with the data contained in Multipart FormData.
// Files should be added to the request with the name of `files`.
// If requested, and if it makes sense to do so, a .gz file is also created.
// Requires authorization. (TODO)
fn handle_create_files(app &App, mut ctx Context) vweb.Result {
	fn_name := 'handle_create_file'

	content_type_header := ctx.get_header(http.CommonHeader.content_type) or {
		return bad_or_missing_header(mut ctx, fn_name)
	}
	if content_type_header != 'multipart/form-data' {
		return bad_or_missing_header(mut ctx, fn_name)
	}

	should_gzip := ctx.query['gzip'] == 'true'

	file_data_array := ctx.files['files']
	for file_data in file_data_array {
		file_path := app.public_directory
		final_file_path := '${file_path}/${file_data.filename}'

		mut file := os.create(final_file_path) or { return ctx.send_error(err, fn_name) }
		file.write(file_data.data.bytes()) or {
			file.close()
			return ctx.send_error(err, fn_name)
		}
		file.close()

		if should_gzip && could_gzip(file_data.filename) {
			gzip_file_name := '${file_data.filename}${gzip_extension}'
			gzip_file_path := '${file_path}/${gzip_file_name}'
			// TODO if any error happens in this block, revert all previous changes to file system
			gzip_file_data := gzip.compress(file_data.data.bytes()) or {
				return ctx.send_error(err, fn_name)
			}
			mut gzip_file := os.create(gzip_file_path) or { return ctx.send_error(err, fn_name) }
			gzip_file.write(gzip_file_data) or {
				gzip_file.close()
				return ctx.send_error(err, fn_name)
			}
			gzip_file.close()
		}
	}
	return ctx.ok('OK')
}

fn bad_or_missing_header(mut ctx Context, fn_name string) vweb.Result {
	message := 'Requests to this endpoint should have the Content-Type multipart/form-data'
	error := new_vistas_error(http.Status.bad_request, message)
	return ctx.send_error(error, fn_name)
}
