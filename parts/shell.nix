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

      shellHook = ''
        ${config.pre-commit.installationScript}
        echo "Welcome to Lunix."
      '';

      packages = [
        # Agenix CLI for managing secrets
        inputs'.agenix.packages.default

        # treewide formatting (so it doesn't get dealyed on nix fmt)
        config.treefmt.build.wrapper

        #Nothing would work without git.
        pkgs.git
      ];
    };
  };
}
