{
  config,
  lib,
  pkgs,
  ...
}: let inherit (lib.modules) mkIf;

loginScript = pkgs.pkgs.writeShellScriptBin "login-startup" ''
  #!/usr/bin/env bash
  set -xeuo pipefail

  gamescopeArgs=(
      --adaptive-sync # VRR support
      #--hdr-enabled
      --mangoapp # performance overlay
      --rt
      --steam
  )
  steamArgs=(
      -pipewire-dmabuf
      -tenfoot
  )
  mangoConfig=(
      cpu_temp
      gpu_temp
      ram
      vram
  )
  mangoVars=(
      MANGOHUD=1
      MANGOHUD_CONFIG="$(IFS=,; echo "$mangoConfig")"
  )

  export "$mangoVars"
  exec gamescope "$gamescopeArgs" -- steam "$steamArgs"  
'';

cfg = config.profiles.gaming;
in {
  config = mkIf (cfg.enable && cfg.programs.steam.enable) {
    programs = {
      gamescope = {
        enable = true;
      };
      steam.gamescopeSession = {
        enable = true;
      };
    };
    services.getty.autoLoginUser = "lunarnova";
    environment.loginShellInit = ''
      [[ "$(tty)" = "/dev/tty1" ]] && ${loginScript}/bin/loginstartup
    '';
  };
}