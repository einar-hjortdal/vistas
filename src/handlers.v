module main

import x.vweb
import os

fn handle_get_file(app App, mut ctx Context, file_name string) vweb.Result {
	file_path := '${app.public_directory}/${file_name}'
	if os.is_file(file_path) {
		return ctx.file(file_path)
	}
	return ctx.not_found()
}
