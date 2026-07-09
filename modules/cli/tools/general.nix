{pkgs, ...}: {
  programs.zoxide.enable = true;
  environment = {
    systemPackages = with pkgs; [
      fd
      bat
      eza
      wl-clipboard-rs
    ];
    shellAliases = {
      cd = "z";
      cat = "bat";
      find = "fd";
      ls = "eza";
      ll = "eza --long";
      lt = "eza --tree";
    };
  };
}
