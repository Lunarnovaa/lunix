{
  theme,
  pkgs,
  ...
}: let
  inherit (builtins) toString;
  inherit (theme.fonts) cjk monospace size;
in {
  # Add support for typing Pinyin -> Hanzi
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        rime-data
        fcitx5-rime
        fcitx5-gtk
        fcitx5-configtool #if having issues with qt compatibility, run fcitx5-config-qt
        fcitx5-chinese-addons
        fcitx5-mozc
      ];
      settings = {
        addons.classicui.globalSection = {
          Theme = "catppuccin-mocha-pink";
          DarkTheme = "catppuccin-mocha-pink";
          UseAccentColor = true;
          Font = cjk.sans.name + toString size;
          MenuFont = monospace.name + toString size;
        };
        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = true;
            EnumerateSkipFirst = false;
            ModifierOnlyKeyTimeout = 250; # ms
          };
          "Hotkey/TriggerKeys"."0" = "Super+space";
          "Hotkey/EnumerateForwardKeys"."0" = "Super+space";
          "Hotkey/EnumerateBackwardKeys"."0" = "Shift+Super+space";
          "Hotkey/PrevPage"."0" = "Up";
          "Hotkey/NextPage"."0" = "Down";
          "Hotkey/PrevCandidate"."0" = "Shift+Tab";
          "Hotkey/NextCandidate"."0" = "Tab";
          "Hotkey/TogglePreedit"."0" = "Control+Alt+P";
          Behavior = {
            ActiveByDefault = false;
            resetStateWhenInFocus = "No";
            ShareInputState = "No";
            PreeditEnabledByDefault = true;
            ShowInputMethodInformation = true;
            showInputMethodInformationWhenInFocus = false; # for some reason this one starts with a lowercase
            CompactInputMethodInformation = true;
            ShowFirstInputMethodInformation = true;
            DefaultPageSize = 5;
            OverrideXkbOptions = false;
            PreloadInputMethod = true;
            AllowInputMethodForPassword = false;
            ShowPreeditForPassword = false;
          };
        };
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us-colemak"; # Default layout
            DefaultIM = "rime"; # Default input method
          };
          "Groups/0/Items/0".Name = "keyboard-us-colemak";
          "Groups/0/Items/1".Name = "rime";
          "Groups/0/Items/2".Name = "keyboard-us";
          GroupOrder."0" = "Default";
        };
      };
    };
  };
  hjem.users.lunarnova.files = let
    themeName = "catppuccin-mocha-pink";
    configDir = ".local/share/fcitx5/themes/${themeName}";
    themeDir = "${pkgs.catppuccin-fcitx5}/share/fcitx5/themes/${themeName}";
  in {
    "${configDir}/arrow.png".source = "${themeDir}/arrow.png";
    "${configDir}/highlight.svg".source = "${themeDir}/highlight.svg";
    "${configDir}/panel.svg".source = "${themeDir}/panel.svg";
    "${configDir}/radio.png".source = "${themeDir}/radio.png";
    "${configDir}/theme.conf".source = "${themeDir}/theme.conf";
  };
}
