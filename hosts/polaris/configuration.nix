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
      google-chrome.enable = true;
      obs.enable = false;
    };
  };
}
