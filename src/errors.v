module main

import x.vweb
import json
import time
import net.http

struct VistasError {
	status    http.Status
	code      int
	msg       string
	timestamp string
}

fn (e VistasError) status() http.Status {
	return e.status
}

fn (e VistasError) code() int {
	return e.code
}

fn (e VistasError) msg() string {
	return e.msg
}

fn (e VistasError) timestamp() string {
	return e.timestamp
}

fn (e VistasError) to_string() string {
	return json.encode(e)
}

fn new_vistas_error(status http.Status, msg string) VistasError {
	return VistasError{
		status: status
		code: int(status)
		msg: msg
		timestamp: time.now().format_rfc3339()
	}
}

fn (mut ctx Context) send_error(error IError, function_name string) vweb.Result {
	if error is VistasError {
		// app.logger.debug('${function_name}: ${error}')
		ctx.res.set_status(error.status)
		return ctx.json(error)
	}
	vistas_error := new_vistas_error(http.Status.internal_server_error, error.msg())
	// app.logger.debug('${function_name} (unhandled): ${error.msg()}')
	ctx.res.set_status(vistas_error.status)
	return ctx.json(vistas_error)
}
