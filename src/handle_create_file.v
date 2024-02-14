module main

import x.vweb
import os
import json

struct CreateFileRequest {
	gzip bool
}

// handle_create_file creates a file in app.public_directory.
// If requested, and if it makes sense to do so, a .gz file is also created.
// Requires authorization. (TODO)
fn handle_create_file(app &App, mut ctx Context) vweb.Result {
	fn_name := 'handle_create_file'
	body := json.decode(CreateFileRequest, ctx.req.data) or { return ctx.send_error(err, fn_name) }
	if body.gzip {
		// if gzip requested, create gzipped file too
	}
	return ctx.ok('OK')
}
