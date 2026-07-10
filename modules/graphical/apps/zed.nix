{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  environment.systemPackages = [pkgs.zed-editor pkgs.nixd];
  hjem.users.lunarnova.xdg.config.files."zed/settings.json" = {
    generator = builtins.toJSON;
    value = {
      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha (pink)";
      };
      auto_install_extensions = {
        nix = true;
        toml = true;
        astro = true;
        catppuccin = true;
        git-firefly = true;
        panache = true;
      };
      journal.hour_format = "hour24";
      project_panel = {
        dock = "left";
        entry_spacing = "standard";
      };
      git.inline_blame.enabled = false;
      title_bar.show_sign_in = false;
      helix_mode = true;
      middle_click_paste = false;
      pane_split_direction_vertical = "right";
      autosave = "on_focus_change";
      buffer_font_family = config.lunix.theme.fonts.monospace.name;
      buffer_font_size = 16;
      buffer_line_height = "standard";
      ui_font_family = config.lunix.theme.fonts.sans.name;
      ui_font_size = 14;
      disable_ai = true;
      load_direnv = "shell_hook";
      formatter.external.command = getExe pkgs.alejandra;
    };
  };
}
