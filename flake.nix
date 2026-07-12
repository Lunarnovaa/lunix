{
  # https://github.com/Lunarnovaa/lunix
  description = "Lunix: Lunarnova's Nix Flake.";

  outputs = {self}: let
    inputs = import ./.tack;

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
        statix
      ];
    };
  };
}
