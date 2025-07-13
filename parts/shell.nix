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

      # Tell Direnv to shut up. From NotAShelf/Nyx
      DIRENV_LOG_FORMAT = "";

      packages = [
        # Agenix CLI for managing secrets
        inputs'.agenix.packages.default

        # Treewide formatting (so it doesn't get delayed on nix fmt)
        config.treefmt.build.wrapper

        # Nothing would work without git.
        pkgs.git

        # Using the Lunix specific Novavim package
        inputs'.novavim.packages.lunix
      ];
    };
  };
}
