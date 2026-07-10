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

      packages = with pkgs; [
        git

        # Pinning with tack
        tack

        # Editing tools
        helix
        lazygit
        zellij
      ];
    };
  };
}
