{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  catppuccin = {
    theme = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "cosmic-desktop";
      rev = "fea2e508f3ab53cf5762a7610f4b6cc3a8f42a95";
      hash = "sha256-P9RFwivSAVJaaX0xpt6Kgn2s7U0O9+yF195BIimn1oI=";
    };
    flavor = "mocha";
    accent = "rosewater";
  };

  cfg = config.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova.files = {
      #".config/cosmic/com.system76.CosmicTheme.Dark/v1".source = "${catppuccin.theme}/themes/cosmic-settings/catppuccin-${catppuccin.flavor}-${catppuccin.accent}+round.ron";
     # ".config/cosmic/com.system76.CosmicSettings.Wallpaper".
    
    };
  };
}
