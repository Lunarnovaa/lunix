{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.lunix.programs.firefox;
in {
  config = mkIf cfg.enable {
    lunix.programs.firefox.settings.policies.SearchEngines.Add = [
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
        Name = "Home Manager Options";
        URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
        Method = "GET";
        Alias = "@hmo";
      }
      {
        Name = "ProtonDB";
        URLTemplate = "https://www.protondb.com/search?q={searchTerms}";
        Method = "GET";
        IconURL = "https://www.protondb.com/sites/protondb/images/site-logo.svg";
        Alias = "@pdb";
      }
      {
        Name = "Rate My Professor";
        URLTemplate = "https://www.ratemyprofessors.com/search/professors/?q={searchTerms}";
        Method = "GET";
        Alias = "@rmp";
      }
    ];
  };
}
