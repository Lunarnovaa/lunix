{pkgs, ...}: {
  hjem.users.lunarnova = {
    packages = [pkgs.zellij];
    files.".config/zellij/config.kdl".text =
      #kdl
      ''
        theme "catppuccin-mocha"
        copy_command "wl-copy"
        simplified_ui true
        show_startup_tips true
        ui {
          pane_frames {
            rounded_corners true
          }
        }
      '';
  };
}
