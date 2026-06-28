{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      ${getExe pkgs.microfetch}
    '';

    inherit (config.environment) shellAliases;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histFile = "${config.hjem.users.lunarnova.xdg.data.directory}/zsh/zsh_history";
    setOptions = ["HIST_IGNORE_ALL_DUPS"];
  };
  users.extraUsers.lunarnova.shell = pkgs.zsh;
}
