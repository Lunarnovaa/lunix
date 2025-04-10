{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) flatten;
  inherit (lib.trivial) pipe;
  inherit (lib.attrsets) getAttrs;
  inherit (builtins) map attrValues;

  extensionUUIDs = pipe cfg.extensions.packages [
    (map (extension:
      pipe extension [
        (getAttrs ["extensionUuid"])
        attrValues
      ]))
    flatten
  ];

  cfg = config.desktops.gnome;
in {
  config = mkIf (cfg.enable && cfg.extensions.enable) {
    environment.systemPackages = cfg.extensions.packages;
    programs.dconf.profiles.lunarnova.databases = [
      {
        settings."org/gnome/shell" = {
          disable-user-extensions = false; # Enable user extensions (lol)
          enabled-extensions = extensionUUIDs;
        };
      }
    ];
  };
}
