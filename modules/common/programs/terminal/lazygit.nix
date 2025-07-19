{
  lunix.programs.terminal.aliases.lg = "lazygit";
  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGpg = true;
    };
  };
}
