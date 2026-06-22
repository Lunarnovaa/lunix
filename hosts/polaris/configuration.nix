{
  config.lunix = {
    profiles.gaming.enable = true;
    hardware = {
      nvidia.enable = true;
    };
    programs = {
      firefox = {
        enable = true;
        app = "mozilla";
      };
      obs.enable = false;
      vial.enable = false;
    };
  };
}
