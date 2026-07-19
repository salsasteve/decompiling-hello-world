#![feature(prelude_import)]
extern crate std;
#[prelude_import]
use std::prelude::rust_2021::*;
fn main() { { ::std::io::_print(format_args!("Hello, world!\n")); }; }
