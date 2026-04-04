{pkgs ? import <nixpkgs> {}}:
pkgs.mkShellNoCC {
  name = "lunix";

  shellHook = let
    #green = ''\033[1;32m'';
    cyan = ''\033[1;36m'';
    #red = ''\033[1;31m'';
    noColor = ''\033[0m'';
  in
    # Bash
    ''
      echo -e "${cyan}Welcome to Lunix.${noColor}"
    '';

  DIRENV_LOG_FORMAT = "";

  packages = [
    # Managing packages with npins
    pkgs.npins
  ];
}
