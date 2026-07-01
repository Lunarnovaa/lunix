{
  # https://github.com/Lunarnovaa/lunix
  description = "Lunix: Lunarnova's Nix Flake.";

  outputs = {self, ...} @ args: let
    inputs = (import ./.tack) {
      overrides = args.tackOverrides or {};
    };

    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = import ./hosts {inherit inputs self;};
    devShells.${system}.default = pkgs.mkShellNoCC {
      name = "lunix";

      DIRENV_LOG_FORMAT = "";

      packages = [
        # Pinning with tack
        #pkgs.tack # not yet merged

        pkgs.helix
      ];
    };
  };
}
