{
  pkgs,
  inputs,
  ...
}: {
  # Allow unfree packages to be installed
  nixpkgs.config.allowUnfree = true;

  nix = {
    # Use lix
    package = pkgs.lix;

    # Enable Flakes
    settings = {
      auto-optimise-store = true; # Automatically optimise the store
      experimental-features = ["nix-command" "flakes"];
    };

    # Flake registry
    registry.lunix.flake = inputs.self;
  };

  # Don't change from 24.05
  system.stateVersion = "24.05"; # Did you read the comment?
}
