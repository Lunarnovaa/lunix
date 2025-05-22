# Lunix

> [!IMPORTANT]
> **Please star my repository if you find it helpful in your own configuration.
> It's free.**

Named "Lunix" as a portmanteau of my username, "Lunarnova," and "Nix," Lunix is
my NixOS configuration I use on all my systems and plan to use on all future
systems.

Having used NixOS since 22 June 2024, Lunix has gone through many, many
iterations and has become a passion project of mine. I am sure that, likewise,
it will continue to be iterated upon, improved, and expanded.

I have learned so much from it. I look forward to learning more.

<div align="center">
    <a href=#structure>Structure</a></br>
    <a href=#hosts>Hosts</a></br>
    <a href=#related-projects>Related Projects</a></br>
    <a href=#Credits>Credits</a>
</div>

> [!CAUTION]
> I do not support you using my flake in your own systems. It is not designed
> for that. I am not keeping it in mind for my development. I strongly
> discourage using someone else's flakes in your configuration. Learn Nix, or
> don't use NixOS.

## Structure

Lunix is structured specifically to be logical and help me work with it. Here's
a basic rundown:

- [`flake.nix`] Nix Flake: The entry-point of my system.
- [`parts`] Flake Modules: The parts of my flake that make up the whole, powered
  by [Flake Parts].
  - [`pkgs`] Nixpkgs Overlay: Custom mkDerivations written by yours truly.
- [`hosts`] System specific configuration: Mainly hardware configuration and
  specific option selection, especially defining the profiles.
- [`modules`] Modular system configuration: The bulk of my system configuration.
  - [`common`] Modules that are generally made available to all my hosts.
  - [`desktops`] Desktop modules: Desktops installed and configured.
  - [`options`] Module Options: Configures what modules are disabled or enabled
    per system and per profile.
  - [`profiles`] Profile modules: Special programs, services, and configuration
    needed on each profile.
- [`secrets`] Agenix Secrets Management.

### How the profiles work

1. Each profile has its own options for enabling and disabling apps and
   installing programs.
2. Each host can select which profiles' modules to import.
3. The profile itself can be enabled or disabled, and this sets the default
   option of its programs to be enabled or disabled by default.

Credit to [@NotAShelf] for inspiration and references.

### Why don't you use Home Manager?

[Home Manager] is a lovely tool for many people that helps manage their dotfiles
for them. I used it myself for the first 6 months of my journey on NixOS. I then
decided it was best to move away from it. With [@NotAShelf] and
[@éclairevoyant]'s [Hjem], I successfully migrated from Home Manager and began
managing my dotfiles myself.

Home Manager has a few problems for me:

1. Abstracts too much,
2. Lengthens eval times, and
3. Can be a nightmare to work with.

In the past, I believed its capabilities were worth the costs. Ultimately,
however, I found an alternate solution and have never looked back.

If you wish to do the same, I would consider this configuration to be a decent
jumping-off point. You may also want to keep an eye on my currently WIP
[Hjem Rum], a module collection for Hjem, offering options similar to Home
Manager. This solves the latter two issues while acknowledging the fact that for
many, the first issue is not a bug but a feature.

### I have a million other questions :c

For a while, I tried to document and explain any quirky choices I made in my
configuration. But at this point, I'm past my limit, and I'm adding more
insanity to it by the week. While I have done my best to (and, I believe, a good
job of) explaining my wacky decisions in the code with comments, if you still
find yourself questioning yours or my sanity, or simply are struck by a wave of
curiosity, feel free to reach out to me.

[`flake.nix`]: ./flake.nix
[`parts`]: ./parts
[Flake Parts]: https://github.com/hercules-ci/flake-parts
[`pkgs`]: ./parts/pkgs
[`hosts`]: ./hosts
[`modules`]: ./modules
[`common`]: ./modules/common
[`desktops`]: ./modules/desktops
[`options`]: ./modules/options
[`profiles`]: ./modules/profiles
[`secrets`]: ./secrets
[@NotAShelf]: https://github.com/NotAShelf
[Home Manager]: https://github.com/nix-community/home-manager
[@éclairevoyant]: https://github.com/eclairevoyant
[Hjem]: https://github.com/feel-co/hjem
[Hjem Rum]: https://github.com/snugnug/hjem-rum

## Hosts

| Name      | Description                                                  |      Profiles       |  Type   |
| :-------- | :----------------------------------------------------------- | :-----------------: | :-----: |
| [polaris] | Primary daily-driver: the first system I installed NixOS on. | Gaming, Workstation | Desktop |
| [procyon] | Framework 13 laptop with a Ryzen 7040.                       |     Workstation     | Laptop  |

[polaris]: ./hosts/polaris
[procyon]: ./hosts/procyon

## Related Projects

Most people maintain everything in a monorepo―I am not one of those people. I
began fracturing my Nix project(s) by starting my Neovim configuration in a
separate repo, titled [Novavim]. I then realized that it would be nice to have
full access to my extended library without needing to input my whole NixOS
configuration. Thus, [Lunar's Libraries] was born.

### Novavim

I moved my Neovim configuration into another repo primarily in order to make it
easy for me to use it on any system without needing access to my NixOS
configuration, and without needing to fully update to a newest version of my
configuration (for when I make large, in-progress changes), and instead allow
myself to simply run it from another repo.

It is also a bit helpful as it allows me to more mentally separate the projects.
While I use Nix to configure my Neovim, I view Novavim as a self-contained
project, rather than as a part of my broader NixOS configuration.

You can see more information over in [Novavim].

### Lunar's (Nix) Libraries

Rather than maintain my full extended library within this singular monorepo, I
moved it into its own as well. Initially, this was so that I could use a
function both in Lunix and in Novavim without needing to input Lunix, with all
its unwieldy inputs and modules. Additionally, I simply find the mental
separation to be gratifying. My extended library is a _toolset_, not a component
of my configurations, whether in Lunix or Novavim.

You can see more information over in [Lunar's Libraries].

[Novavim]: https://www.github.com/lunarnovaa/novavim
[Lunar's Libraries]: https://www.github.com/lunarnovaa/lunarslib

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

[GPLv3]: ./LICENSE
