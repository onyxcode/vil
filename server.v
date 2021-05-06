module main

import vweb
import term
import os

#include <signal.h>

fn handler(signal os.Signal) {
	println('')
	exit(0)
}

struct App {
	vweb.Context
}

fn main() {
	os.signal_opt(.hup, handler) or { eprintln(term.bright_yellow(term.bold('Warning: ') + 'failed to attach hangup signal')) }
	os.signal_opt(.int, handler) or { eprintln(term.bright_yellow(term.bold('Warning: ') + 'failed to attach interrupt signal')) }

	port := match os.getuid() {
		0 { 80 }
		else { 8080 }
	}
	vweb.run<App>(port)
	exit(0)
}

pub fn (mut app App) index() vweb.Result {
	if app.ip().starts_with('192.168.') {
		ip := app.ip() + (' - ' + term.bright_green('Local IP'))
		println('IP logged: ' + term.bold(ip))
	} else {
		ip := app.ip() + (' - ' + term.bright_magenta('Foreign IP'))
		println('IP logged: ' + term.bold(ip))
	}
	return $vweb.html()
}
