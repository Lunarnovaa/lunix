{pkgs, ...}: {
  # Make Chromium + Electron apps use Wayland
  hjem.users.lunarnova.packages = [pkgs.wl-clipboard-rs];
  lunix.environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
