{
  pkgs,
  config,
  ...
}: let
  email = "35857948+Lunarnovaa@users.noreply.github.com";
  /*
    signingKey = "${config.hjem.users.lunarnova.directory}/.ssh/polaris.pub";
  signingKey = "/etc/ssh/ssh_host_ed25519_key.pub";

  signersFile = pkgs.writeText "git-allowed-signers" ''
    ${email} namespaces="git" ${signingKey}
  '';
  */
in {
  #config.hjem.users.lunarnova.files.".config/git/allowed_signers".source = signersFile;
  config.programs.git = {
    enable = true;
    config = {
      user = {
        inherit email; #signingKey;
        name = "lunarnovaa";
      };
      init.defaultBranch = "main";
      /*
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = signersFile;
      };
      commit.gpgSign = true;
      tag.gpgSign = true;
      */
    };
  };
}
