{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.meta) getExe;
  toml = pkgs.formats.toml {};

  flakeRev = "github:Lunarnovaa/lunix/769cd7d9f47134a1f2e6ea97aee4fbe35d9be464";
  flakeOptions = "(builtins.getFlake ${flakeRev}).nixosConfigurations.${config.networking.hostName}.options";
in {
  lunix.environment.sessionVariables.EDITOR = "hx";
  hjem.users.lunarnova.xdg.config.files."helix/languages.toml".source = toml.generate "helix-languages.toml" {
    language-server = {
      bash-language-server.command = "${pkgs.bash-language-server}/bin/bash-language-server";
      marksman.command = "${pkgs.marksman}/bin/marksman";
      nixd = {
        command = "${pkgs.nixd}/bin/nixd";
        args = [
          "--nixos-options-expr=${flakeOptions}"
        ];
      };
      nu = {
        command = "${pkgs.nushell}/bin/nu";
        args = ["--lsp"];
      };
      qmlls = {
        command = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
        args = ["-E"];
      };
      ruff = {
        command = "${pkgs.ruff}/bin/ruff";
        args = ["server"];
      };
      tinymist.command = "${pkgs.tinymist}/bin/tinymist";
      tombi = {
        command = "${getExe pkgs.tombi}";
        args = ["lsp"];
      };
      typescript-language-server.command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
      vscode-css-languageserver.command = "${pkgs.vscode-css-languageserver}/bin/vscode-css-languageserver";
      yaml-language-server.command = "${pkgs.yaml-language-server}/bin/yaml-language-server";
    };
    language = [
      {
        name = "bash";
        auto-format = true;
        language-servers = ["bash-language-server"];
      }
      {
        name = "css";
        auto-format = true;
        language-servers = ["vscode-css-languageserver"];
      }
      {
        name = "kdl";
        auto-format = true;
        # formatter = {
        #   command = "${pkgs.kdlfmt}/bin/kdlfmt";
        #   args = ["format"];
        # };
      }
      {
        name = "markdown";
        auto-format = true;
        formatter = {
          command = "${pkgs.deno}/bin/deno";
          args = ["fmt" "-" "--ext" "md"];
        };
        language-servers = ["marksman"];
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        language-servers = ["nixd"];
      }
      {
        name = "nu";
        auto-format = true;
        language-servers = ["nu"];
      }
      {
        name = "python";
        auto-format = true;
        language-servers = ["ruff"];
      }
      {
        name = "qml";
        auto-format = true;
        formatter = {
          command = "${pkgs.kdePackages.qtdeclarative}/bin/qmlformat";
          args = ["--inplace" "--tabs" "--indent-width 2"];
        };
        language-servers = ["qmlls"];
      }
      {
        name = "toml";
        language-servers = ["tombi"];
      }
      {
        name = "typescript";
        auto-format = true;
        language-servers = ["typescript-language-server"];
      }
      {
        name = "typst";
        auto-format = true;
        formatter.command = "${pkgs.typstyle}/bin/typstyle";
        language-servers = ["tinymist"];
      }
      {
        name = "yaml";
        auto-format = true;
        language-servers = ["yaml-language-server"];
      }
    ];
  };
}
