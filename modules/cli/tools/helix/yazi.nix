{
  pkgs,
  inputs,
  ...
}: {
  environment.shellAliases.y = "yazi";
  programs.yazi = {
    enable = true;
    flavors.catppuccin-mocha = "${inputs.yazi-flavors}/catppuccin-mocha.yazi";
    plugins = {
      inherit (pkgs.yaziPlugins) rich-preview smart-enter;
    };
    settings = {
      theme.flavor.dark = "catppuccin-mocha";
      yazi.mgr.show_hidden = true;
      keymap = {
        mgr.prepend_keymap = [
          {
            on = "<Right>";
            run = "plugin smart-enter";
            desc = "Enter the child directory, or open the file";
          }
        ];
      };
    };
  };
}
