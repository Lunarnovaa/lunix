{
  config.lunix = {
    hardware = {
      nvidia.enable = true;
    };
    programs = {
      firefox = {
        enable = true;
        app = "mozilla";
      };
      obs.enable = true;
      vial.enable = false;
    };
  };
}
