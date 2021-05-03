module main

import vweb
import term

struct App {
    vweb.Context
}

fn main() {
    vweb.run<App>(80)
}

pub fn (mut app App) index() vweb.Result {
	if app.ip().starts_with("192.168.") {
		ip := app.ip() + (" - " + term.bright_green("Local IP"))
		println("IP logged: " + term.bold(ip))
	}
	else {
		ip := app.ip() + (" - " + term.bright_magenta("Foreign IP"))
		println("IP logged: " + term.bold(ip))
	}
	return $vweb.html()
}