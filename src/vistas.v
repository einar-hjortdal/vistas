module main

import x.vweb
import os
import strconv
import coachonko.dotenv

struct Context {
	vweb.Context
}

pub struct App {
	public_directory string
}

fn main() {
	dotenv.load()

	public_directory := os.getenv('PUBLIC_DIRECTORY')
	run_at_port := strconv.atoi(os.getenv('PORT')) or { 8080 }

	mut app := &App{
		public_directory: string_default_if_empty(public_directory, 'public')
	}
	setup(app)

	vweb.run[App, Context](mut app, run_at_port)
}
