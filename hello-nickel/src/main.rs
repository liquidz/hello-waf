#[macro_use]
extern crate nickel;

use nickel::{Nickel, HttpRouter};

fn main() {
    let mut server = Nickel::new();
    server.get("**", middleware!("Hello Nickel World"));
    server.listen("localhost:3001");
}
