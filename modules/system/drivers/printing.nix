{
  # Enable CUPS to Print
  services.printing.enable = true;

  # Enable Autodiscovery of Printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
