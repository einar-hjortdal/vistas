module main

import x.vweb
import os

// handle_list_files returns a list of files available to be served.
// Requires authorization. (TODO)
fn handle_list_files(app &App, mut ctx Context) vweb.Result {
	entries := os.ls(app.public_directory) or { [] }
	return ctx.json(entries)
}
