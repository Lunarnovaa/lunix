{
  pkgs,
  config,
  ...
}: let
  yaml = pkgs.formats.yaml {};

  email = "35857948+Lunarnovaa@users.noreply.github.com";
  signingKey = "${config.hjem.users.lunarnova.directory}/.ssh/id_ed25519.pub";
  signersFile = pkgs.writeText "git-allowed-signers" ''
    ${email} namespaces="git" ${signingKey}
  '';
in {
  config = {
    hjem.users.lunarnova.files = {
      ".config/git/allowed_signers".source = signersFile;
      ".config/lazygit/config.yml".source = yaml.generate "lazygit-config.yml" {
        git.overrideGpg = true;
      };
    };
    programs.git = {
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
  };
}
