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
    ## Systems is a fancy flake to unify the systems ##
    ## for which the flake and its inputs are built. ##

    systems = {
      # Currently only use x86_64-linux :)
      url = "github:nix-systems/x86_64-linux";
    };

    # use the unstable branch
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # for docs
    ndg = {
      url = "github:lunarnovaa/ndg?ref=improve-toc";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
      };
    };
    ## system infrastructure ##

    # used for my laptop
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; #no nixpkgs necessary

    impermanence.url = "github:nix-community/impermanence";

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

    # modularizing my flake
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # managing pre-commit hooks with nix
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    ## module specific stuff ##

    # manage wi-fi through launcher
    iwmenu = {
      url = "github:e-tho/iwmenu";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        rust-overlay.follows = "rust-overlay";
      };
    };

    # manage bluetooth through launcher
    bzmenu = {
      url = "github:e-tho/bzmenu";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        rust-overlay.follows = "rust-overlay";
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

    # minecraft server configured with nix and ran as a service
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    ## shelfware ##

    # base16 palettes in nix
    basix = {
      url = "github:notashelf/basix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
      };
    };

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

    # Lunar's (Nix) Libraries
    lunarsLib = {
      url = "github:lunarnovaa/lunarslib";
      #url = "path:/home/lunarnova/projects/LunarsLibraries";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*
    schizofox = {
      url = "path:/home/lunarnova/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hjem.follows = "hjem";
        home-manager.follows = "";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
        flake-compat.follows = "flake-compat";
      };
    };
    */
    ## hjem business ##

    # hjem, a replacement for home-manager's tooling
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # i use a local version for dogfeeding
    hjem-rum = {
      url = "github:snugnug/hjem-rum/";
      #url = "github:nezia1/hjem-rum/use-formats";
      #url = "path:/home/lunarnova/projects/snug/hjem-rum";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hjem.follows = "hjem";
        ndg.follows = "ndg";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    # input unification - not used here, but so that we can decrease redundant flake inputs
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
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

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
