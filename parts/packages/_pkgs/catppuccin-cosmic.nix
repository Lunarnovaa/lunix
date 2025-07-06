{
  pkgs ? import <nixpkgs> {},
  flavor ? "mocha",
  accent ? "rosewater",
  roundness ? "square",
  window_hint_color ? accent,
  bg_alpha ? 1.0,
  frosted ? true,
  outer_gap_size ? 4,
  inner_gap_size ? outer_gap_size,
  active_hint_size ? 1,
  ...
}: let
  inherit (pkgs) fetchFromGitHub stdenv;
  inherit (builtins) toJSON;

  settings = toJSON {
    inherit
      accent
      roundness
      window_hint_color
      bg_alpha
      frosted
      outer_gap_size
      inner_gap_size
      active_hint_size
      ;
  };
in
  stdenv.mkDerivation {
    name = "catppuccin-cosmic";

    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "cosmic-desktop";
      rev = "fea2e508f3ab53cf5762a7610f4b6cc3a8f42a95";
      hash = "sha256-P9RFwivSAVJaaX0xpt6Kgn2s7U0O9+yF195BIimn1oI=";
    };

    nativeBuildInputs = [pkgs.catppuccin-whiskers];

    buildPhase = ''
      runHook preBuild

      mkdir result
      cd result
      whiskers ../templates/cosmic-settings.tera --flavor ${flavor} --overrides='${settings}'

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/share/themes/cosmic-settings"
      cp themes/cosmic-settings/catppuccin-${flavor}-${accent}+${roundness}.ron "$out/share/themes/cosmic-settings/catppuccin-cosmic.ron"

      runHook postInstall
    '';

    installTargets = ["themes"];

    meta = {
      description = "Catppuccin theme for COSMIC.";
    };
  }
