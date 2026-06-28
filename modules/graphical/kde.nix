{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.lists) singleton;
in {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
  };
  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      elisa
      kate
      ktexteditor
    ];
    systemPackages = singleton (pkgs.catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["pink"];
      winDecStyles = ["classic"];
    });
  };
}
