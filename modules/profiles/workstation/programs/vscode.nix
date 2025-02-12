{
  inputs,
  lib,
  config,
  pkgs,
  theme,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (theme) fonts;
  inherit (config.profiles) workstation;

  flakeRev = "github:lunarnovaa/nixconf/f0d8932b16f1055fe2e1647d2a02e5a3213206d2";
  flakeOptions = "(builtins.getFlake ${flakeRev}).nixosConfigurations.${config.networking.hostName}.options";
in {
  config = mkIf workstation.apps.vscode {
    hjem.users.lunarnova = {
      rum.programs.vscode = {
        enable = true;
        settings = {
          "editor.semanticHighlighting.enabled" = true;
          "terminal.integrated.minimumContrastRatio" = 1;
          "window.titleBarStyle" = "custom";

          "editor.fontFamily" = "${fonts.monospace.name}";
          "editor.fontLigatures" = true;
          "workbench.colorTheme" = "Catppuccin Mocha";

          "catppuccin"."accentColor" = "rosewater";

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
