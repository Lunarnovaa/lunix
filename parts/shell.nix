{
  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    # More minimal shell environment, excluding C Compilers
    devShells.default = pkgs.mkShellNoCC {
      name = "lunix";

      shellHook = ''
        echo "Welcome to Lunix."

      '';

      packages = [
        # Agenix CLI for managing secrets
        inputs'.agenix.packages.default
      ];
    };
  };
}
