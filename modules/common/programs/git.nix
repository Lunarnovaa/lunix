{
  pkgs,
  config,
  ...
}: let
  signingKey = "${config.hjem.users.lunarnova.directory}/.ssh/id_ed25519.pub";
  email = "35857948+Lunarnovaa@users.noreply.github.com";

  signersFile = pkgs.writeText "git-allowed-signers" ''
    ${email} namespaces="git" ${signingKey}
  '';
in {
  config.hjem.users.lunarnova.files.".config/git/allowed_signers".source = signersFile;

  config.programs.git = {
    enable = true;
    config = {
      user = {
        inherit email signingKey;
        name = "lunarnovaa";
      };
      init.defaultBranch = "main";

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = signersFile;
      };
      commit.gpgSign = true;
      tag.gpgSign = true;
    };
  };
}
