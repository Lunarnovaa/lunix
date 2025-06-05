{
  imports = [
    ./modules # Special modules designed to be included in specialArgs

    ./pkgs # My own packages

    ./fmt.nix # Formatters

    ./pre-commit.nix # git-hooks for nix

    ./shell.nix # Lunix's Development Shell
  ];
}
