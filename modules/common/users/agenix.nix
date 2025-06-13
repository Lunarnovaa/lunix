{
  inputs',
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.strings) optionalString;

  secretsDir = ../../../secrets;

  cfgImpermanence = config.lunix.hardware.impermanence;
in {
  environment.systemPackages = [inputs'.agenix.packages.default];
  age.secrets = {
    spotifyPassword.file = secretsDir + /spotifyPassword.age;
    spotifyClientID.file = secretsDir + /spotifyClientID.age;
  };
  imports = [inputs.agenix.nixosModules.default];
  age.identityPaths = [
    "${optionalString cfgImpermanence.enable "/persist"}/etc/ssh/ssh_host_ed25519_key"
    "${optionalString cfgImpermanence.enable "/persist"}/etc/ssh/ssh_host_rsa_key"
  ];
}
