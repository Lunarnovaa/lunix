{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (builtins) toJSON;

  toINI = lib.generators.toINI {};

  cfg = config.lunix.programs.firefox;
in {
  hjem.users.lunarnova = mkIf (cfg.enable && (cfg.app == "mozilla")) {
    packages = [pkgs.firefox];
    files = {
      ".mozilla/firefox/profiles.ini".text = toINI {
        Profile0 = {
          # creates lunarnova profile and sets it as default
          Name = "lunarnova";
          IsRelative = 1;
          Path = "lunarnova";
          Default = 1;
        };
      };
      ".mozilla/firefox/distribution/policies.json".text = toJSON {
        policies = {
          SearchEngines.Default = "DuckDuckGo";
        };
      };
    };
  };
}
