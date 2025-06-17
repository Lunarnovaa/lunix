{lib, ...}: {
  perSystem = {
    pkgs,
    inputs',
    config,
    ...
  }: let
    inherit (lib.meta) getExe;
  in {
    # More minimal shell environment, excluding C Compilers
    devShells.default = pkgs.mkShellNoCC {
      name = "lunix";

      shellHook = let
        green = ''\033[1;32m'';
        cyan = ''\033[1;36m'';
        red = ''\033[1;31m'';
        noColor = ''\033[0m'';
      in
        # Bash
        ''
          ${config.pre-commit.installationScript}
          echo -e "${cyan}Welcome to Lunix."

          echo -e "Launch Novavim? [${green}y/${red}N${cyan}]${noColor}"
          read -n 1 launch

          if [ "$launch" = "y" ]; then
            ${getExe inputs'.novavim.packages.lunix}
          fi
        '';

      packages = [
        # Agenix CLI for managing secrets
        inputs'.agenix.packages.default

        # Treewide formatting (so it doesn't get delayed on nix fmt)
        config.treefmt.build.wrapper

        # Nothing would work without git.
        pkgs.git

        # Managing pinned packages with npins
        pkgs.npins
      ];
    };
  };
}
