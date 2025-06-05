{inputs, ...}: {
  # Import the lix module
  imports = [inputs.lix-module.nixosModules.default];

  # Allow unfree packages to be installed
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Flake registry
  nix.registry.lunix.flake = inputs.self;

  # Don't change from 24.05
  system.stateVersion = "24.05"; # Did you read the comment?
}
