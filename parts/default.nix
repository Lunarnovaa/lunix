{
  imports = [
    ./apps # Special derivations to be run with 'nix run'

    ./misc # Miscellaneous flake settings

    ./modules # Special modules designed to be included in specialArgs

    ./pkgs # My own packages
  ];
}
