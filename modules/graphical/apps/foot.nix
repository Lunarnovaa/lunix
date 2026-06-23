{config, ...}: {
  programs.foot = {
    enable = true;
    theme = "catppuccin-mocha";
    xdg.serverAutostart = true;
    settings = {
      main.font = "monospace:size=12";
      environment = config.lunix.environment.sessionVariables;
      colors-dark.alpha = 0.9;
    };
  };
}
