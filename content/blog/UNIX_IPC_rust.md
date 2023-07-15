---
title: "UNIX domain socket IPC in Rust."
date: 2022-02-08
tags: ["Rust", "Waycrate"]
draft: false
---

The [IPC patch](https://github.com/waycrate/swhkd/pull/10) is complete and has been merged into the main branch.

The patch was made possible with the [interprocess crate](https://crates.io/crates/interprocess) and was later rewritten to raw stdlib implementation
in [this commit](https://github.com/waycrate/swhkd/commit/35d4960d87b8e2ac6e8a32fd642b1f7555f3ec2a). Currently the server binary (`swhks`) makes a
socket at `/run/user/(YourUserID)/swhkd.sock` which then the daemon binary (`swhkd`) tries to establish a connection with.

After merging the initial set of patches [Ckyiu](https://github.com/unsignedarduino) found 2 issues right away:

- Calling the function `physical_path()` on any `evdev::Device` object returns None on virtual machines and hence the binary panics and crashes while
  attempting to execute `.unwrap()` on it. This issue has been taken care of in this [commit.](https://github.com/waycrate/swhkd/commit/1e01014a1436a3983f09c57574b0bca4ff5adfcb)

- The old error message "Invoking user is NOT in input group." would lead users to add themselves to the input group, and we definitely don't want that
  as stated in the [previous blog](https://shinyzenith.xyz/blogs/swhkd_rust_rewrite/). To counter this issue, [swhkd now warns the user](https://github.com/waycrate/swhkd/commit/faecfcf61784a1dfe3c43fa8b4ca303c5b3137b5) if they have input group access and gracefully exits.

All that remains now is config file handling which has been assigned to [Angelo Fallaria](https://angelo.is-a.dev/), and key event handling which I will
be implementing.

That is all for now 😀.
