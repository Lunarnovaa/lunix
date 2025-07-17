{pkgs, ...}: let
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
in {
  # Make Chromium + Electron apps use Wayland
  config = {
    inherit environment;
    hjem.users.lunarnova = {
      inherit environment;
      packages = [pkgs.wl-clipboard-rs];
    };
  };
}
