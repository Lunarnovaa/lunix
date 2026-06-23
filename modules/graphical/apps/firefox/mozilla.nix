{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.lists) singleton;
  inherit (lib.modules) mkIf;

  cfg = config.lunix.programs.firefox;
in {
  hjem.users.lunarnova = mkIf (cfg.enable && (cfg.app == "mozilla")) {
    packages = singleton (pkgs.firefox.override {
      extraPolicies = cfg.settings.policies;
    });
  };
}
