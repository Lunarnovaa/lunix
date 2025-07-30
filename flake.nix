{
  # https://github.com/Lunarnovaa/lunix
  description = "Lunix: Lunarnova's Nix Flake.";

  outputs = inputs: let
    inherit (inputs.lunarsLib.importers) listNixRecursive;
    mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
  in
    mkFlake {
      imports = listNixRecursive ./parts ++ [./hosts];

      # Systems for which the flake will be built is made relative
      # of the systems flake input (referenced from NotAShelf/nyx)
      systems = import inputs.systems;
    };

  inputs = {
    # secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        # stop agenix from importing home-manager and darwin
        home-manager.follows = "";
        darwin.follows = "";
      };
    };

    # base16 palettes in nix
    basix = {
      url = "github:notashelf/basix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
      };
    };

    # modularizing my flake
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    # managing pre-commit hooks with nix
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    # hjem, a replacement for home-manager's tooling
    hjem = {
      url = "github:lunarnovaa/hjem?ref=xdgFiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum?ref=improve-gtk";
      #url = "github:nezia1/hjem-rum?ref=use-formats";
      #url = "path:/home/lunarnova/projects/snug/hjem-rum";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hjem.follows = "hjem";
        ndg.follows = "ndg";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    impermanence.url = "github:nix-community/impermanence";

    # Lunar's (Nix) Libraries
    lunarsLib = {
      url = "github:lunarnovaa/lunarslib";
      #url = "path:/home/lunarnova/projects/LunarsLibraries";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for docs
    ndg = {
      url = "github:lunarnovaa/ndg?ref=improve-toc";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
      };
    };

    # minecraft server configured with nix and ran as a service
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    # used for my laptop
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; #no nixpkgs necessary

    # use the unstable branch
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Lunarnova's Neovim Configuration
    novavim = {
      url = "github:lunarnovaa/novavim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        nvf.follows = "nvf";
        flake-parts.follows = "flake-parts";
      };
    };

    # a spotify ricer
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    # Currently only use x86_64-linux :)
    systems.url = "github:nix-systems/x86_64-linux";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # input unification - not used here, but so that we can decrease redundant flake inputs
    flake-compat = {
      url = "github:edolstra/flake-compat";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-utils.follows = "flake-utils";
        systems.follows = "systems";
      };
    };
  };
}
