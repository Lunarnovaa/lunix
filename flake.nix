{
  # https://github.com/Lunarnovaa/lunix
  description = "Lunix: Lunarnova's Nix Flake.";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./hosts
        ./parts
      ];

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
      url = "github:feel-co/hjem";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-darwin.follows = "";
      };
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      #url = "github:nezia1/hjem-rum?ref=use-formats";
      #url = "path:/home/lunarnova/projects/snugnug/upstream/hjem-rum";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hjem.follows = "hjem";
        ndg.follows = "ndg";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs = {
        home-manager.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
    };
    # Lunar's (Nix) Libraries
    lunarsLib = {
      url = "github:lunarnovaa/lunarslib";
      # url = "path:/home/lunarnova/projects/LunarsLib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # for docs - avoid following nixpkgs
    ndg.url = "github:feel-co/ndg?ref=v2.5.1"; # pin NDG to benefit from binary cache

    # used for my laptop
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; #no nixpkgs necessary

    # use the unstable branch
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Currently only use x86_64-linux :)
    systems.url = "github:nix-systems/x86_64-linux";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # input unification - not used here, but so that we can decrease redundant flake inputs
    flake-compat = {
      url = "github:edolstra/flake-compat";
    };
  };
}
