{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.lunix.programs.firefox;
in {
  hjem.users.lunarnova.programs.schizofox.search.addEngines = mkIf (cfg.enable && (cfg.app == "schizofox")) [
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
      Alias = "@pdb";
      IconURL = "https://www.protondb.com/sites/protondb/images/site-logo.svg";
    }
    {
      Name = "Rate My Professor";
      URLTemplate = "https://www.ratemyprofessors.com/search/professors/1506?q={searchTerms}";
      Method = "GET";
      Alias = "@rmp";
    }
  ];
}
