{
  inputs',
  inputs,
  ...
}: let
  secretsDir = ../../../secrets;
in {
  environment.systemPackages = [inputs'.agenix.packages.default];
  age.secrets = {
    userPassword.file = secretsDir + /userPassword.age;
    wifiPassword.file = secretsDir + /wifiPassword.age;
    spotifyPassword.file = secretsDir + /spotifyPassword.age;
    spotifyClientID.file = secretsDir + /spotifyClientID.age;
  };
  imports = [inputs.agenix.nixosModules.default];
  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];
}
