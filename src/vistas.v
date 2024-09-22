module main

import veb
import os
import strconv
import einar_hjortdal.dotenv

struct Context {
	vweb.Context
}

pub struct App {
	mode             string
	public_directory string
}

fn main() {
	dotenv.load()

	mut app := create_app_instance() or { panic(err) }
	setup(app)

	env_run_at_port := strconv.atoi(os.getenv('PORT')) or { 8080 }
	vweb.run[App, Context](mut app, env_run_at_port)
}
