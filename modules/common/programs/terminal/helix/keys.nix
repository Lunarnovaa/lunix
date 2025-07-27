{pkgs, ...}: {
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
      space.t.p = ":sh ${pkgs.tinymist}/bin/tinymist preview %{buffer_name} --partial-rendering";
      # Select name + value
      "'" = "@ghvglmmx";
      # Select till end of line
      ret = "@vgl";
    };
  };
}
