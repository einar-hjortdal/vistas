module main

import x.vweb
import os
import coachonko.dotenv

struct Context {
	vweb.Context
}

pub struct App {}

fn main() {
	dotenv.load()

	port := os.getenv('PORT').int()

	setup()

	mut app := App{}
	vweb.run[App, Context](mut app, port)
}
