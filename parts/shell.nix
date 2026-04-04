{
  perSystem = {
    pkgs,
    inputs',
    config,
    ...
  }: {
    # More minimal shell environment, excluding C Compilers
    devShells.default = pkgs.mkShellNoCC {
      name = "lunix";

      shellHook = let
        #green = ''\033[1;32m'';
        cyan = ''\033[1;36m'';
        #red = ''\033[1;31m'';
        noColor = ''\033[0m'';
      in
        # Bash
        ''
          ${config.pre-commit.installationScript}
          echo -e "${cyan}Welcome to Lunix.${noColor}"
        '';

      DIRENV_LOG_FORMAT = "";

      packages = [
        # Treewide formatting (so it doesn't get delayed on nix fmt)
        config.treefmt.build.wrapper

        # Managing packages with npins
        pkgs.npins

      ];
    };
  };
}
