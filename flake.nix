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
    # modularizing my flake
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    # managing pre-commit hooks with nix
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs = {
        nixpkgs.follows = "nixpkgs";
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

    # use the unstable branch
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Currently only use x86_64-linux :)
    systems.url = "github:nix-systems/x86_64-linux";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
