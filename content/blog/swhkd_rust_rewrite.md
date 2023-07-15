---
title: "Rewriting swhkd in rust!"
date: 2022-02-07
tags: ["Rust", "Waycrate", "Wayland"]
draft: false
---

Hi all! It's high time I put this domain purchase to use and uploaded my first blog.


I started a project called swhkd a few weeks back which stands for the **S**imple **W**ayland **H**ot**K**ey **D**aemon.

Swhkd is a drop in replacement for the popular X11 utility [sxhkd](https://github.com/baskerville/sxhkd), which is a hotkey daemon.
Don't let the name fool you, swhkd is compatible with X11, WayLand, and TTY.

Initially I wrote a python prototype which worked well for a concept but was a memory hog, consuming upto 19Mb for just printing the device key events.
I was initially considering zig or go for the rewrite but then I decided to give the RIIR ( rewrite it in rust ) meme a try.

Rust definitely lived up to it's name. [After the rewrite](https://github.com/waycrate/swhkd/pull/7) the code isn't too hard to read and it's really
performant ( 4kb memory consumption for the entire execution ). However rust's memory management model of ownership and borrowing did take me quite a while to
get comfortable with.

Swhkd uses the [evdev](https://crates.io/crates/evdev) crate for getting all keyboard events from the kernel directly. This gives us a uniform protocol to acccess
keyevents irrelavant of the display server, unlike sxhkd's X11 direct key event grab ( one of the security risks of using X11 ).

For swhkd to read the key events the user invoking must be in the input group, which is inherently insecure as all programs running as said user can directly read the
entire key event stream from the kernel ( making wayland the same as X11... ).
This problem is solved by making a polkit policy file for swhkd which allows users to run swhkd as root without a password.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN" "http://www.freedesktop.org/standards/PolicyKit/1/policyconfig.dtd">
<policyconfig>
  <action id="com.github.swhkd.pkexec">
    <message>Authentication is required to run Simple Wayland Hotkey Daemon</message>
    <defaults>
      <allow_any>no</allow_any>
      <allow_inactive>no</allow_inactive>
      <allow_active>yes</allow_active>
    </defaults>
	<annotate key="org.freedesktop.policykit.exec.path">/usr/bin/swhkd</annotate>
  </action>
</policyconfig>
```

Currently I'm [writing](https://github.com/waycrate/swhkd/pull/10) the client to receive the shell commands. On every key trigger the daemon should
send a shell command back to the client using UNIX socket IPC according to the keybind callback function.

More updates will be available soon™.
