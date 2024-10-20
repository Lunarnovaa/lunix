let
  #generated with sudo ssh-keygen -A
  #sourced from /etc/ssh/ssh_host_ed25519_key.pub
  polaris = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2iAb15Y/Zwrt8k5BPfneZ0Cl8tcr7bEPZ4/UUlCZIG";
  procyon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQGQ9oOq+wEYNkGwZ/IXAaCIzzKudjNTu4yoGPDzxx8";
in {
  "userPassword.age".publicKeys = [polaris procyon];
  "wifiPassword.age".publicKeys = [polaris procyon];
}
