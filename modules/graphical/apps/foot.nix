{config, ...}: {
  programs.foot = {
    enable = true;
    theme = "catppuccin-mocha";
    xdg.serverAutostart = true;
    settings = {
      main = {
        initial-window-size-chars = "101x30";
        font = "monospace:size=12";
      };
      environment = config.lunix.environment.sessionVariables;
      colors-dark.alpha = 0.9;
    };
  };
}
