{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.theme) fonts;
  inherit (config.profiles) workstation;

  flakeRev = "github:lunarnovaa/nixconf/f0d8932b16f1055fe2e1647d2a02e5a3213206d2";
  flakeOptions = "(builtins.getFlake ${flakeRev}).nixosConfigurations.${config.networking.hostName}.options";
in {
  config = mkIf workstation.apps.vscode {
    hjem.users.lunarnova = {
      rum.programs.vscode = {
        enable = true;
        settings = {
          "editor.fontFamily" = "${fonts.monospace.name}";
          "editor.fontLigatures" = true;
          "workbench.colorTheme" = "Catppuccin Mocha";
          "catppuccin"."accentColor" = "red";

          "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
          "nix.enableLanguageServer" = true;

          "nix.serverSettings"."nixd" = {
            "nixpkgs"."expr" = "import ${inputs.nixpkgs} { }";

            "formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];

            "options"."nixos"."expr" = flakeOptions;
          };

          "files.exclude" = {
            "**/.git" = false;
          };
        };
      };
    };
  };
}
