{
  # Enable Networking
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd.settings = {
      Network.EnableIPv6 = true;
      Settings.AutoConnect = true;
      General.AddressRandomization = "network";
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [25565];
    };
  };
  #Enable Bluetooth
  hardware.bluetooth.enable = true;
}
