module main

import vweb
import term
import os

#include <signal.h>

fn handler() {
	println('')
	exit(0)
}

struct App {
    vweb.Context
}

fn main() {
	os.signal(2, handler)
	os.signal(1, handler)
    mut prompt := os.input_opt("Please enter `y` if you are sudo/root, otherwise enter `n`.\n➥ ") or {
			exit(1)
			panic('Exiting: $err')
		}
	match prompt {
	"y" {
		vweb.run<App>(80)
	}
	"n" {
		vweb.run<App>(8080)
	}
	else {
		println("Exiting...")
	}
	}
	exit(0)
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