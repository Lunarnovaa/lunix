# Lunix

> [!NOTE]
> I've decided to leave NixOS, as it is a bit much to maintain for my usecase. I
> truly enjoyed my time with Nix, and who knows, perhaps I'll come back some day.
> In the meantime, feel free to use this repo as a reference for one particular
> way to write Nix.

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

## Structure

I have taken all of my Nix knowledge with the aim of making Lunix as easy to
maintain and as simply designed as possible.

Lunix is structured specifically to be logical and help me work with it. Here's
a basic rundown:

- [`flake.nix`] Nix Flake: The entry-point of my system.
- [`hosts`] System specific configuration: Mainly hardware configuration and
  specific option selection, especially defining the profiles.
- [`modules`] Modular system configuration: The bulk of my system configuration.
- [`npins`] A better pinning solution

## Why don't you use Home Manager?

[Home Manager] is a lovely tool for many people that helps manage their dotfiles
for them. I used it myself for the first 6 months of my journey on NixOS. I then
decided it was best to move away from it. With [@NotAShelf] and
[@éclairevoyant]'s [Hjem], I successfully migrated from Home Manager and began
managing my dotfiles myself.

Home Manager has a few problems for me:

1. Abstracts too much,
2. Lengthens eval times, and
3. Can be a nightmare to work with.

Really, I just think it makes more sense to manage my dotfiles directly. I started and
worked on [Hjem Rum] for a while, but it ultimately led to more work than I wanted. So
I mostly just use Hjem plus generators to write my dotfiles with Nix.

[`flake.nix`]: https://github.com/lunarnovaa/lunix/tree/main/flake.nix
[`hosts`]: https://github.com/lunarnovaa/lunix/tree/main/hosts
[`modules`]: https://github.com/lunarnovaa/lunix/tree/main/modules
[`npins`]: https://github.com/lunarnovaa/lunix/tree/main/npins
[@NotAShelf]: https://github.com/NotAShelf
[Home Manager]: https://github.com/nix-community/home-manager
[@éclairevoyant]: https://github.com/eclairevoyant
[Hjem]: https://github.com/feel-co/hjem
[Hjem Rum]: https://github.com/snugnug/hjem-rum

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
