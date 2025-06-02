{inputs, ...}: {
  imports = [inputs.git-hooks.flakeModule];

  perSystem = let
    # Heavily inspired from NotAShelf/nyx
    excludes = ["LICENSE" "flake.lock" "\.age$"];
    mkHook = name: config:
      {
        inherit name excludes;
        description = "pre-commit hook for ${name}.";
      }
      // config;
  in {
    pre-commit = {
      check.enable = true;
      settings = {
        inherit excludes;
        hooks = {
          treefmt = mkHook "treefmt" {
            enable = true;
          };
          lychee = mkHook "lychee" {
            enable = true;
            # Excludes anything not a markdown file
            excludes = ["^(?!.*\.md.*)"]; # Expression from NotAShelf/nyx
          };
        };
      };
    };
  };
}
