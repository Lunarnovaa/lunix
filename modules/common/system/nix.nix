{
  pkgs,
  inputs,
  ...
}: {
  # Allow unfree packages to be installed
  nixpkgs.config.allowUnfree = true;

  nix = {
    # Enable Flakes
    settings.experimental-features = ["nix-command" "flakes"];

    # Use lix
    package = pkgs.lix;

    # Flake registry
    registry.lunix.flake = inputs.self;
  };

  # Don't change from 24.05
  system.stateVersion = "24.05"; # Did you read the comment?
}
