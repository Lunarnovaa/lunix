{
  # Enable Networking
  networking = {
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [25565];
    };
  };
  #Enable Bluetooth
  hardware.bluetooth.enable = true;
}
