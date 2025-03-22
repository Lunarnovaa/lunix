# Lunix

> [!IMPORTANT]
> **Please star my repository if you find it helpful in your own config. It's free.**

Named "Lunix" as a portmanteau of my username, "Lunarnova," and "Nix," Lunix is my NixOS config I use on all my systems and plan to use on all future systems.

Having used NixOS since 22 June 2024, my config has gone through many, many iterations and has become a passion project of mine. I am sure that, likewise, it will continue to be iterated upon, improved, and expanded.

I have learned so much from it. I look forward to learning more.

<div align="center">
    <a href=#structure>Structure</a></br>
    <a href=#hosts>Hosts</a></br>
    <a href=#Credits>Credits</a>
</div>

> [!CAUTION]
> I do not support you using my flake in your own systems. It is not designed for that. I am not keeping it in mind for my development. I strongly discourage using someone else's flakes in your config. Learn Nix, or don't use NixOS.

## Structure

Lunix is structured specifically to be logical and help me work with it. Here's a basic rundown:

- [`flake.nix`](./flake.nix) Nix Flake: The entry-point of my system.
- [`parts`](./parts) Flake Modules: The parts of my flake that make up the whole, powered by [Flake Parts](https://github.com/hercules-ci/flake-parts).
  - [`lib`](./parts/lib) Extended Lib: Custom function declaration
  - [`pkgs`](./parts/pkgs) Nixpkgs Overlay: Custom mkDerivations written by yours truly
- [`hosts`](./hosts) System specific configuration: Mainly `hardware-configuration.nix` and specific option selection, especially defining the profiles.
  - [`configuration.nix`](./hosts/polaris/configuration.nix) Host-specific configuration & module selection
  - [`hardware-configuration.nix`](./hosts/polaris/hardware-configuration.nix) Auto-generated per-host
- [`modules`](./modules) Modular system configuration: The bulk of my system configuration
  - [`common`](./modules/common) Modules that are generally made available to all my hosts.
  - [`desktop`](./modules/desktop) Desktop modules: Desktops installed and configured.
  - [`options`](./modules/options) Module Options: Configures what modules are disabled or enabled per system and per profile
  - [`profiles`](./modules/profiles) Profile modules: Special programs, services, and configuration needed on each profile.
- [`secrets`](./secrets) Agenix Secrets Management

### How the profiles work

1. Each profile has its own options for enabling and disabling apps and installing programs.
2. Each host can select which profiles' modules to import.
3. The profile itself can be enabled or disabled, and this sets the default option of its programs to be enabled or disabled by default.

Credit to [@NotAShelf](https://github.com/NotAShelf/Nyx) for inspiration and references.

### Why don't you use Home Manager?

[Home Manager](https://github.com/nix-community/home-manager) is a lovely tool for many people that helps manage their dotfiles for them. I used it myself for the first 6 months of my journey on NixOS. I then decided it was best to move away from it. With [@NotAShelf](https://github.com/NotAShelf) and [@éclairevoyant](https://github.com/eclairevoyant)'s [Hjem](https://github.com/feel-co/hjem), I successfully migrated from Home Manager and began managing my dotfiles myself.

Home Manager has a few problems for me, in increasing severity:

1. Abstracts too much;
2. Lengthens eval times; and
3. Requires a differentiation between HM modules and Nix modules.

In the past, I structured Lunix to account for the differentiation between the two module types, but it caused me  inconveniences that I would rather have gone without.

If you wish to do the same, I would consider this config to be a decent jumping-off point. You may also want to keep an eye on my currently WIP [Hjem Rum](https://github.com/the-unnamed-nug/hjem-rum), a module collection for hjem, offering options similar to Home Manager. This solves the latter two issues while not neglecting the fact that for many, the first issue is not a bug but a feature.

### I have a million other questions :c

For a while, I tried to document and explain any quirky choices I made in my config. But at this point, I'm past my limit, and I'm adding more insanity to it by the week. If you have any questions for how or why I did something a certain way, you can feel free to reach out to me.

## Hosts

| Name                          | Description                                                                                     | Profiles            | Type    |
| :---------------------------  | :---------------------------------------------------------------------------------------------- | :-----------------: | :-----: |
| [`polaris`](./hosts/polaris/) | Primary daily-driver: the first system I installed NixOS on.                                    | Gaming, Workstation | Desktop |
| [`procyon`](./hosts/procyon/) | Framework 13 laptop with a Ryzen 7040.                                                          | Workstation         | Laptop  |

## Credits

No project is done alone. This is especially so in the FOSS World. I would like to credit and thank the following people for sharing their configuration, wisdom, or knowledge:

### The Originators of My Passion

[@0atman](https://github.com/0atman), whose NixOS video first got me interested in the space.

[@vimjoyer](https://github.com/vimjoyer), for his videos, and for his public nixconf, which I learned and referenced for my own configuration early on.

### SNUG

[@NotAShelf](https://github.com/NotAShelf), for enough reasons that I am certain to leave something out. For his now archived Nix config, for the extensive help and patience he has given me, and for being insane enough to do a lot that I have learned from. Much of my config is heavily inspired by his.

[@PolarFill](https://github.com/PolarFill), for collaborating with me on [Hjem Rum](https://github.com/snugnug/hjem-rum) and providing me with his thoughts.

[@nezia1](https://github.com/nezia1), also for collaborating with me on [Hjem Rum](https://github.com/snugnug/hjem-rum), as well as for being a cool person.

Many other members from [SNUG](https://github.com/snugnug), who have collaborated with me on projects like [Hjem Rum](https://github.com/snugnug/hjem-rum) and also allowed me to engage with community to further pursue Nix.

### Other members of the NixOS community

[@viperML](https://github.com/viperML), especially for his blogposts from which I learned to write mkDerivations, but also for his projects like [nh](https://github.com/viperML/nh).

[@itslychee](https://github.com/itslychee), for help on Discord.

This list will be sure to grow, and I have probably missed people. So to everyone else I have interacted with on my Nix journey, thank you.

## Licensing

Unless explicitly stated otherwise, all code within this repo is protected under [GPLv3](./LICENSE). If you use any of my code please give me credit with a comment, an optional mention in the README, and please give my repo a star.
