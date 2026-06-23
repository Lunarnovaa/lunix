{
  config.lunix = {
    profiles.gaming.enable = true;
    hardware = {
      nvidia.enable = true;
      display.resolution = "2560x1440";
    };
    programs = {
      firefox = {
        enable = true;
        app = "mozilla";
      };
      obs.enable = false;
    };
  };
}
