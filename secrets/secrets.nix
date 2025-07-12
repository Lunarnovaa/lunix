let
  # generated with sudo ssh-keygen -A
  # sourced from /etc/ssh/ssh_host_ed25519_key.pub
  # with impermanence, that's under /persist/etc/ssh
  polaris = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOeTOmn3rRyNnN6N7RToQRFuETFgTmkb2G85PeuFqXYd";
  procyon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIGYSp7arWyY+hebvg67Ze1fe1s4AvneR9A5VvOFHpuw";
  publicKeys = [polaris procyon];
in {
  "spotifyPassword.age" = {inherit publicKeys;};
  "spotifyClientID.age" = {inherit publicKeys;};
}
