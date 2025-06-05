{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  version ? "v0.1.3",
  nerd ? true, # Include nerdfont icons
  type ? "Mono", # 'Mono' or 'Term'
  ...
}: let
  inherit (pkgs) fetchurl stdenv;
  inherit (lib.strings) concatStrings optionalString;

  fontName = concatStrings [
    type
    (optionalString nerd "Nerd")
  ];

  hash = {
    "v0.1.3" = {
      "Mono" = "1dkw4x9vsw2ysjn6m6p9r4rg012hl8hwfkmap8jivr6xs8yrncn5";
      "MonoNerd" = "08asdzan247m5cginjk5wr1cnc5idhn50i5fva7hhb3qisx3hmys";
      "Term" = "1sg7fyhpf6awaw7pbfpmg9a9qrpza7440rcx78ki4spjg5ly6zkw";
      "TermNerd" = "0r4nii9v3nr1vpgg6sbf9w94q8sqjjnyq02naj1rf5k8brwhyc9a";
    };
  };
in
  stdenv.mkDerivation {
    pname = "ioshelfka";
    inherit version;

    src = fetchurl {
      # note: if url is changed, so too must hash be
      url = "https://github.com/NotAShelf/Ioshelfka/releases/download/${version}/Ioshelfka${fontName}.zip";
      sha256 = hash.${version}.${fontName};
    };

    sourceRoot = ".";

    nativeBuildInputs = with pkgs; [
      unzip
    ];

    installPhase = ''
      runHook preInstall

      install -Dm644 result/share/fonts/truetype/*.ttf -t $out/share/fonts/truetype

      ${
        optionalString nerd
        "install -Dm644 result/share/fonts/truetype/NerdFonts/NerdFonts/Ioshelfka${type}/*.ttf -t $out/share/fonts/truetype/NerdFonts/NerdFonts/Ioshelfka${type}"
      }

      runHook postInstall
    '';

    meta = {
      description = "Ioshelfka font.";
    };
  }
