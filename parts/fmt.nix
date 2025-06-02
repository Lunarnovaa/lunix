{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = {config, ...}: {
    formatter = config.treefmt.build.wrapper;
    treefmt = {
      projectRootFile = "flake.nix";

      settings = {
        global.excludes = ["*.age" "*.envrc"];
      };

      programs = {
        alejandra.enable = true;
        deno.enable = true;
        prettier.enable = true;
        biome.enable = true;
      };
    };
  };
}
