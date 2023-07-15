---
title: "NextWM!"
date: 2022-06-04
tags: ["Python", "Wayland"]
draft: false
---

# Choosing a language:

Hi! in my current quest of writing a useable wayland compositing window manager I have gone down a deep rabbit hole.

The wlroots repository lists the following wrapper libraries:

> `Chicken Scheme`, `Common Lisp`, `Go`, `Godot`, `Haskell`, `OCaml`, `Python`, `Qt`, `Rust`, `Swift`, `Zig`

Don't be fooled by this list! All of these wrapper libraries are unmaintained apart from Python and Zig 😔.

With the above in mind, I have tried multiple languages to write a compositor with and here are my cumulative thoughts:

## C:

I simply don't want to write my compositor in C as it's easy to shoot yourself in the foot with it.

## C++:

Same reasons as C, and on top of that importing wlroots headers into C++ in itself is a [messy](https://github.com/swaywm/wlroots/issues/682) task
including prepocessor re-definitions etc.

## Nim:

It was initially working till it didn't...

I'm still not quite sure why the [callbacks](https://github.com/Shinyzenith/nim-wl/blob/devel/src/libherb.nim#L125=) that I had registered didn't work.

If you do, feel free to reach out to me via Email or via [GitHub issue](https://github.com/Shinyzenith/nim-wl/issues/new).

## Zig:

Zig is a fine language to use for compositors given the amazing work [@Ifreund](https://github.com/ifreund/) has put in which includes but is not limited to:

- [Zig-pixman](https://github.com/ifreund/zig-pixman) - Pixman bindings.
- [Zig-wayland](https://github.com/ifreund/zig-wayland) - Libwayland bindings.
- [Zig-wlroots](https://github.com/swaywm/zig-wlroots) - Wlroots bindings.
- [Zig-xkbcommon](https://github.com/ifreund/zig-xkbcommon) - Xkbcommon bindings.

That being said, Zig is still an unstable language which hasn't even had a 1.0 release yet.

Hence I don't want to commit to writing my entire stack in Zig just yet.

I am however writing a small helper [screenshot utility](https://github.com/shinyzenith/zigshot) in Zig ([wayshot](https://github.com/waycrate/wayshot) clone) for
teaching myself and others who want to learn more about the wayland ecosystem.

## Rust:

> Although **Smithay isn't the same as wlroots**, it's still a worthy candidate to mention on this list due to the fact that you can write compositors
> which are **just as functional** with it too.

I've recently started contributing to [wayland-rs](https://github.com/smithay/wayland-rs) and [smithay-client-toolkit](https://github.com/smithay/client-toolkit)
and you should too! they're in need of more contributors and as you can imagine, maintaining pure rust libwayland bindings is a herculean task.

> The devs have been nothing but patient with me even when I asked stupid questions over and over again in their matrix channel.

All of my wayland knowledge comes from writing numerous wayland clients with wayland-rs and talking to [cmeissl](https://github.com/cmeissl),
[i509VCB](https://github.com/i509VCB) and [Victor Berger](https://github.com/vberger) from the smithay team.

That being said, Smithay just isn't as mature as wlroots yet. A lot more manual labor is needed just for the tinywl equivalent of wlroots in smithay...you
can assume how much it would scale up for a proper usable compositor (None written in smithay yet). This paird with the fact that the **wayland-rs API
is undergoing a massive breaking change** for release candidate **0.3.0**, makes it too volatile to commit to in terms of server side just yet.

> However, **client side API won't change too** much with release candidate 0.3.0 and I'd say it's a pleasant experience to write wayland clients in rust.

> On a separate note, check out the [Jay compositor](https://github.com/mahkoh/jay). I think the dev is on crack? they implemented practically everything
> on their own:
>
> - Wayland protocol.
> - Wire protocol.
> - Dbus interface.
> - EGL wrapper.
> - GBM wrapper.
> - OpenGL renderer.
>
> The project doesn't even depend on libwayland!!! 🤯🤯🤯

## Python:

Python to me is a first class candidate for writing compositors. It's not easy to shoot yourself in the foot with, simple enough to write and most importantly,
it has [maintained bindings](https://github.com/flacjacket/pywlroots).

The question might arise "What will you do when the bindings are no longer maintained?".

I don't think qtile will become irrelevant anytime soon hence the bindings will stay maintained for a long time.

"What does qtile have to do with wlroots python bindings?", pywlroots and pywayland are both maintained by [Sean Vig](https://github.com/flacjacket)
from the qtile team!

---

# The Verdict:

It should come of no surprise to you that **I picked python**. I have created the repo and invited a [friend of mine](https://github.com/actualdankcoder)
to develop NextWM with me.

---

# Source Code Availability and Support:

I will follow through with one of the following:

1. Keep the source private until get paid to release it. If I do get paid, I will provide 100% support for the lifetime of the project. This is because
   **I'm tired of offering my free labor**, I write my software to **teach myself and use in my workflow** and not to provide support for other issues
   which are irrelevant to my usecase.

1. Keep the code open-source under [0BSD license](https://spdx.org/licenses/0BSD.html) and stop giving a fuck about bug reports/feature requests I
   get which are irrelevant to me unless I get paid to escalate their priority. I made the mistake of caring too much with [swhkd](https://github.com/waycrate/swhkd)
   and instead got back github issues like such: ["see man sxhkd to know other modifiers that sxhkd support instead of waiting people to report them one by one"](https://github.com/waycrate/swhkd/issues/125)

I'm sorry but I wrote swhkd for my usecase as I needed a hotkey daemon and I bind features as and when requested if I don't need them already. I
don't like that attitude.

I kept this out of the GitHub issue tracker to keep it professional but that comment made me realize that I cared too much about what people think of
my project so it can gain more popularity.

> **This is in no way an invitation to harass the author of the issue and is only my thoughts on the matter.**

That is all for now, have a nice day 😀.
