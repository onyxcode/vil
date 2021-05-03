module main

import vweb

struct App {
    vweb.Context
}

fn main() {
    vweb.run<App>(8080)
}

pub fn (mut app App) index() vweb.Result {
	ip := app.ip()
	println("IP logged: $ip")
	return $vweb.html()
}