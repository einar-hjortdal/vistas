module main

import x.vweb
import net.http
import os

fn send_file(mut ctx Context, file_path string) vweb.Result {
	if os.is_file(file_path) {
		return ctx.file(file_path)
	}
	return ctx.not_found()
}

fn send_compressed_file(mut ctx Context, file_extension string, file_path string) vweb.Result {
	content_type := get_content_type(file_extension)
	ctx.set_header(http.CommonHeader.content_encoding, 'gzip')
	ctx.set_header(http.CommonHeader.vary, 'Accept-Encoding')
	ctx.set_content_type(content_type)
	return ctx.file(file_path)
}

// handle_get_file serves the requested file, only in development.
fn handle_serve_file(app &App, mut ctx Context, file_name string) vweb.Result {
	if app.mode == 'production' {
		return ctx.request_error("You're running vistas in production mode. Your files should be served by your web server (eg. Apache httpd)")
	}

	file_path := '${app.public_directory}/${file_name}'

	accepted_encoding := ctx.get_header(http.CommonHeader.accept_encoding) or {
		return send_file(mut ctx, file_path)
	}

	if !accepted_encoding.contains('gzip') {
		return send_file(mut ctx, file_path)
	}

	file_extension := get_compressible_file_extension(file_name) or {
		return send_file(mut ctx, file_path)
	}

	compressed_file_path := '${file_path}${gzip_extension}'
	if os.is_file(compressed_file_path) {
		return send_compressed_file(mut ctx, file_extension, compressed_file_path)
	}
	return send_file(mut ctx, file_path)
}
