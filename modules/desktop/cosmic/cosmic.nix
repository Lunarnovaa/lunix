{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.cosmic;
in {
  imports = [inputs.nixos-cosmic.nixosModules.default];
  
  config = mkIf cfg.enable {
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true; # By default this is enabled
    };
  };
}
