{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.lists) singleton;
in {
  hjem.users.lunarnova.packages = singleton (pkgs.firefox.override {
    extraPolicies = {
      SearchEngines = {
        Default = "DuckDuckGo";
        Add = [
          {
            Name = "Nix Packages";
            URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
            Method = "GET";
            Alias = "@np";
          }
          {
            Name = "Nix Options";
            URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
            Method = "GET";
            Alias = "@no";
          }
          {
            Name = "NixOS Wiki";
            URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
            Method = "GET";
            Alias = "@nw";
          }
          {
            Name = "ProtonDB";
            URLTemplate = "https://www.protondb.com/search?q={searchTerms}";
            Method = "GET";
            IconURL = "https://www.protondb.com/sites/protondb/images/site-logo.svg";
            Alias = "@pdb";
          }
        ];
      };
    };
  });
}
