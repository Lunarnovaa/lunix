{inputs, ...}: {
  imports = ["${inputs.nixos-hardware}/framework/13-inch/7040-amd"];
  config.lunix = {
    programs = {
      helium.enable = true;
      praat.enable = true;
    };
  };
}
