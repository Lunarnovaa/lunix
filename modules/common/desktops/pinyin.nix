{pkgs, ...}: {
  # Add support for typing Pinyin -> Hanzi
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = [
      pkgs.rime-data
      pkgs.fcitx5-rime
      pkgs.fcitx5-gtk
      pkgs.fcitx5-configtool #if having issues with qt compatibility, run fcitx5-config-qt
      pkgs.fcitx5-chinese-addons
      pkgs.fcitx5-mozc
    ];
  };
}
