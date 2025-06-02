{
  imports = [
    ./apps # Special derivations to be run with 'nix run'

    ./modules # Special modules designed to be included in specialArgs

    ./pkgs # My own packages

    ./fmt.nix # Formatters

    ./shell.nix # Lunix's Development Shell
  ];
}
