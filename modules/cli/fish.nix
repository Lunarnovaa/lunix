{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  users.extraUsers.lunarnova.shell = pkgs.fish;
  hjem.users.lunarnova.xdg.config.files."fish/themes/catppuccin-mocha.theme".source = "${inputs.catppuccin-fish}/static/catppuccin-mocha.theme";
  programs.fish = {
    enable = true;
    inherit (config.environment) shellAliases;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_config theme choose "catppuccin-mocha"
      ${getExe pkgs.microfetch}
    '';
  };
}
