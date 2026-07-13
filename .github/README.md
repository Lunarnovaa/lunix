<h1 align="center"> Lunix </h1>

> [!IMPORTANT]
> Please star my repository if you find it helpful in your own configuration.
> It's free.

Named "Lunix" as a portmanteau of my username, "Lunarnova," and "Nix," Lunix is
my NixOS configuration I use on all my systems and plan to use on all future
systems.

Having used NixOS since 22 June 2024, Lunix has gone through many, many
iterations and has become a passion project of mine. I am sure that, likewise,
it will continue to be iterated upon, improved, and expanded.

I have learned so much from it. I look forward to learning more.

> [!CAUTION]
> I do not support you using my flake in your own systems. It is not designed
> for that. I am not keeping it in mind for my development. I strongly
> discourage using someone else's flakes in your configuration. Learn Nix, or
> don't use NixOS.

## Design Goals & Tech Stack

You'll notice I do things in my config very differently than what is considered
standard; I don't use Home Manager, I don't have a `flake.nix`, my config is modularized but lacks any noticeable
`imports` declarations, etc. I'll explain some of these choices in the following
sections.

Generally speaking, I've designed Lunix with two goals in mind:

1. To be as stable as possible ensuring my system works when I need it to;
2. To be as easy to maintain as possible.

There are times when these conflict, and they are ordered intentionally. These
aims are present in many choices like [using tack instead of flakes] for
pinning, importing en masse with a function as opposed to having `default.nix`'s
everywhere and having to manage manually importing every file, even
[avoiding Home Manager], with all its messy assumptions and relying on its
maintainers to do a good job of managing my system.

I would argue that NixOS is fundamentally designed in such a way that maximizes
the first, often at the cost of the second. In the past, Lunix has become so
overengineered that it has become a maintenance burden―this is something I now
work to avoid as much as possible. Thus, I have developed an idiosyncratic style
in order to improve the second as much as possible while still improving the
first wherever possible.

[using tack instead of flakes]: #tack-a-better-pinning-system
[avoiding Home Manager]: #replacing-home-manager-with-hjem

### Replacing Home Manager with Hjem

The core issue with [Home Manager] is that its modules fundamentally act as
black boxes, configuring and managing your system, in ways that you don't fully
understand it. Truly, if one was to fully understand it, its entire purpose
would be negated. Managing your own dotfiles is not really much harder than
using Home Manager, even if you wish to configure everything in Nix. However, it
does take an understanding of your programs' configuration style, the options
present, and a grappling with how to translate Nix into various configuration
languages, when that is something you want.

One can absolutely use Home Manager merely to write to files in Home, but Home
Manager is designed in such a way that importing its huge module system creates
performance issues. Eventually, I used [@NotAShelf] and [@éclairevoyant]'s
[Hjem] to migrate from Home Manager, writing and managing my dotfiles myself.
You can see this all over Lunix.

The alternative to this is to wrap packages. However, I have found this produces
edge cases where many programs are not designed to be used like this. While it
could in theory lead to a more reproducible experience, I have found just
dealing with home files themselves leads to a much more stable and consistent
experience. You'll see this pattern, of using Nix as a tool, and not as an
ideology, is something I have tried to replicate consistently.

I would be remiss if I didn't mention my old project, [Hjem Rum], which I
created to basically provide the module system Home Manager provides, but built
on Hjem's tooling, and with better design decisions. After suffering from RSI
for the better part of a year, I handed over maintainership to [@GetPsyched],
and I have no plans to return, merely using Hjem to manage my dotfiles.

[@NotAShelf]: https://github.com/NotAShelf
[Home Manager]: https://github.com/nix-community/home-manager
[@éclairevoyant]: https://github.com/eclairevoyant
[Hjem]: https://github.com/feel-co/hjem
[Hjem Rum]: https://github.com/snugnug/hjem-rum
[@GetPsyched]: https://github.com/GetPsyched

### tack: A better pinning system

The perils of Flake's pinning system has been [long debated]. I myself find
flakes in general to be kind of awful, but its pinning system especially bad,
for a plethora of reasons, which does not need to be discussed in depth. Over
the past year or so, I made attempt after attempt to minimize my use of flakes,
and at one point, gutted most of my config just to trim my inputs down to
`nixpkgs`, using npins and fetching functions for most things.

Recently, however, the folks over at [manic.systems] released their pinning
solution they call [tack]. This solution works like a combination of something
like npins and something like flakes, yet with a significantly improved
interface, declaratively managed in `toml` (gone are the days of pinning through
a cli, or worse, the pseudo-Nix of `flake.nix`[^1]). It allows you to fetch
flakes or tarballs indiscriminately, and has fantastic ergonomics (somehow
better than the "Nix" in `flake.nix`). Furthermore, it includes features like
lazy fetching, improving performance over flakes.

[^1]: As you probably have discovered, `flake.nix` isn't actually truly Nix in
    the same way as any other Nix file is. For example, you can't have an expr
    like `inputs = let ... in {};`, even though that is perfectly valid Nix
    code. The `inputs` section especially is arguably like json masquerading as
    Nix, which is probably one of the most inane design decisions in all of Nix.

Initially, I moved to tack without deleting `flake.nix`, only deleting `inputs`.
Tack's comfortable design allowed me this midstep that improved performance and
ergonomics without requiring me to make particularly significant changes to my
config. In fact, tack feels like it was designed to take a npins/flakes hybrid
and resolve their differences and synthesize something better. 

Finally, however, I replaced `flake.nix` with [`system.nix`], which actually was
a lot easier than I expected. The main difficulty was the sheer lack of documentation,
with flakes being overwhelmingly pushed and standardized everywhere, and this new
standard being implemented but otherwise mostly ignored. If you, too, want to do this,
I implore you to learn from Lunix here.

[long debated]: https://discourse.nixos.org/t/a-call-for-the-nix-team-to-present-a-unified-front-on-the-outcome-and-strategy-around-nix-flakes/54959
[manic.systems]: https://github.com/manic-systems/
[tack]: https://github.com/manic-systems/tack
[`system.nix`]: https://github.com/Lunarnovaa/lunix/blob/main/system.nix

## Credits

No project is done alone. This is especially so in the FOSS World. I would like
to credit and thank the following people for sharing their configuration,
wisdom, or knowledge:

### The Originators of My Passion

[@0atman], whose NixOS video first got me interested in the space.

[@vimjoyer], for his videos, and for his public nixconf, which I learned and
referenced for my own configuration early on.

### SNUG

[@NotAShelf], for enough reasons that I am certain to leave something out. For
his now archived [Nyx], for the extensive help and patience he has given me, and
for being insane enough to do a lot that I have learned from. Much of my
configuration is heavily inspired by his.

[@PolarFill], for collaborating with me on [Hjem Rum] and providing me with his
thoughts.

[@nezia1], also for collaborating with me on [Hjem Rum], as well as for being a
cool person.

Many other members from [SNUG], who have collaborated with me on projects like
[Hjem Rum] and also allowed me to engage with community to further pursue Nix.

### Other members of the NixOS community

[@viperML], especially for his blogposts from which I learned to write
mkDerivations, but also for his projects like [nh].

[@itslychee], for help on Discord.

This list will be sure to grow, and I have probably missed people. So to
everyone else I have interacted with on my Nix journey, thank you.

[@0atman]: https://github.com/0atman
[@vimjoyer]: https://github.com/vimjoyer
[Nyx]: https://github.com/NotAShelf/Nyx
[@PolarFill]: https://github.com/PolarFill
[@nezia1]: https://github.com/nezia1
[SNUG]: https://github.com/snugnug
[@viperML]: https://github.com/viperML
[nh]: https://github.com/viperML/nh
[@itslychee]: https://github.com/itslychee

## Licensing

Unless explicitly stated otherwise, all code within this repo is protected under
[GPLv3]. If you use any of my code please give me credit with a comment, an
optional mention in the README, and please give my repo a star.

[GPLv3]: https://github.com/lunarnovaa/lunix/blob/main/LICENSE
