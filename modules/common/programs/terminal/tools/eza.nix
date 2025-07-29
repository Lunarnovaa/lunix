{pkgs, ...}: let
  catppuccinTheme = pkgs.fetchFromGitHub {
    owner = "eza-community";
    repo = "eza-themes";
    rev = "57149851f07b3ee6ca94f5fe3d9d552f73f8b8b4";
    hash = "sha256-vu6QLz0RvPavpD2VED25D2PJlHgQ8Yis+DnL+BPlvHw=";
  };
in {
  lunix.programs.terminal.aliases = {
    ll = "eza -l";
    lt = "eza --tree";
  };
  hjem.users.lunarnova = {
    packages = [pkgs.eza];
    xdg.config.files."eza/theme.yml".source = "${catppuccinTheme}/themes/catppuccin.yml";
  };
}
