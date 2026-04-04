{
  hjem.users.lunarnova.rum.programs.direnv = {
    enable = true;
    integrations.nushell.enable = true;
    # as yoinked from nixpkgs, this makes direnv output silent
    settings.global = {
      log_format = "-";
      log_filter = "^$";
    };
  };
}
