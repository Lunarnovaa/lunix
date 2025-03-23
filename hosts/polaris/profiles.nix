{...}: {
  # Set and configure specific profiles
  profiles = {
    gaming = {
      enable = true;
      programs.obs.enable = false;
    };
    workstation = {
      enable = true;
    };
  };
}
