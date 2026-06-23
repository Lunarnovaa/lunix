{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib.strings) concatStringsSep;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.meta) getExe;
  inherit (builtins) replaceStrings;
  inherit (lib.trivial) pipe;

  # These are taken from Hjem Rum. But I wrote them, so. Either way, GPLv3.
  variables = variables: ''
    load-env {${concatStringsSep ", " (mapAttrsToList (n: v: "${n}: \"${v}\"") variables)}}
  '';
  #this one has actually been modified a bit to include replace strings
  aliases = aliases:
    pipe aliases [
      (mapAttrsToList (n: v: "alias ${n} = ${v}"))
      (map (replaceStrings ["&&"] [";"]))
      (concatStringsSep "\n ")
    ];
in {
  environment = {
    systemPackages = [pkgs.nushell];
    shells = [pkgs.nushell];
  };
  programs.bash.interactiveShellInit =
    # bash
    ''
      if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
        exec nu --execute ${getExe pkgs.microfetch}
      fi
    '';
  hjem.users.lunarnova.xdg.config.files."nushell/config.nu".text =
    #nu
    ''
      source ${inputs.catppuccin-nushell}/themes/catppuccin_mocha.nu

      ${variables config.lunix.environment.sessionVariables}
      ${aliases config.environment.shellAliases}

      def lunix [] { cd ~/Projects/lunix ; zellij }

      $env.config = {
        show_banner: false
        completions: {
          case_sensitive: false
          quick: false
          partial: true
          algorithm: "fuzzy"
        }
      }
        # carapace completions https://www.nushell.sh/cookbook/external_completers.html#carapace-completer
        # + fix https://www.nushell.sh/cookbook/external_completers.html#err-unknown-shorthand-flag-using-carapace
      let carapace_completer = {|spans|
        ${getExe pkgs.carapace} $spans.0 nushell ...$spans | from json
      }
      $env.CARAPACE_LENIENT = 1

      # some completions are only available through a bridge
      # eg. tailscale
      # https://carapace-sh.github.io/carapace-bin/setup.html#nushell
      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

      mkdir ($nu.data-dir | path join "vendor/autoload")
      starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
    '';
  programs.starship = {
    enable = true;
    presets = ["nerd-font-symbols"];
    settings.palette = "catppuccin-mocha";
  };
}
