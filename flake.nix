{
  # https://github.com/Lunarnovaa/lunix
  description = "Lunix: Lunarnova's Nix Flake.";

  outputs = {self}: let
    inputs = import ./.tack;

    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = import ./hosts {inherit inputs self;};
    devShells.${system}.default = import ./shell.nix {inherit inputs pkgs;};
  };
}
