---
title: "Wayland Compositor written in nim."
date: 2022-03-22
tags: ["Nim", "Wayland"]
draft: false
---

Recently I started an organization named [Waycrate](https://github.com/waycrate) to write high quality wayland tools. Being drunk in the wayland craze
I took it upon myself to rewrite BSPWM for Wayland. Since the waycrate team has already finished rewriting [sxhkd for wayland](https://github.com/waycrate/swhkd),
this makes my work a tad bit simpler.

I have decided to name the window manager HerbWM which [uncomfyhalomacro](https://github.com/uncomfyhalomacro) came up with.

The [futhark](https://github.com/pmunch/futhark) library has done nothing but shock me with it's fantastic support for C. I have no regrets with respect
to using the library other than the fact that it doesn't support inline functions or function like macros, a common work around to this is just to
redefine the inline function in nim.

Currently the source code of [HerbWM](https://github.com/waycrate/herbwm) is written in Zig but I have already started implementing
[tinywl in nim](https://github.com/waycrate/nim-wl) which if successful, will be merged into upstream herbwm.
