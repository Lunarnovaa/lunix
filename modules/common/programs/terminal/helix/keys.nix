{
  hjem.users.lunarnova.rum.programs.helix.settings.keys = {
    normal = {
      # Launch
      l = {
        # Yazi
        y = [
          ":sh rm -f /tmp/unique-file"
          ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
          ":insert-output echo '\x1b[?1049h\x1b[?2004h' > /dev/tty"
          ":open %sh{cat /tmp/unique-file}"
          ":redraw"
        ];
        # Lazygit
        g = [
          ":new"
          ":insert-output lazygit"
          ":buffer-close!"
          ":redraw"
        ];
      };
      # Apostrophe
      "'" = {
        # Select name + value and delete, change, or yank respectively
        d = "@ghvglmmxd";
        c = "@ghvglmmxc";
        y = "@ghvglmmxy";
        # Select till end of line and delete, change, or yank respectively
        e = {
          d = "@vgld";
          c = "@vglc";
          y = "@vgly";
        };
      };
    };
  };
}
