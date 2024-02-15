module main

import x.vweb

@['/file/:file_name'; get]
fn (app &App) get_file(mut ctx Context, file_name string) vweb.Result {
	return handle_serve_file(app, mut ctx, file_name)
}

@['/api/files'; get]
fn (app &App) list_files(mut ctx Context) vweb.Result {
	return handle_list_files(app, mut ctx)
}

@['/api/files/:file_name...'; post]
fn (app &App) create_file(mut ctx Context, file_name string) vweb.Result {
	return handle_create_file(app, mut ctx, file_name)
}

@['/api/files/:file_name...'; delete]
fn (app &App) delete_file(mut ctx Context, file_name string) vweb.Result {
	return ctx.json('{}')
}

@['/api/health'; get]
fn (app &App) health(mut ctx Context) vweb.Result {
	// health status
	return ctx.json('{}')
}
