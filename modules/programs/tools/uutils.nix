{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      fd
      bat
      eza
    ];
    shellAliases = {
      cat = "bat";
      find = "fd";
      ls = "eza";
      ll = "eza --long";
      lt = "eza --tree";
    };
  };
}
