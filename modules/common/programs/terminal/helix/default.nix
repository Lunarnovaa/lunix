{
  lunix.environment.sessionVariables.EDITOR = "hx";
  hjem.users.lunarnova = {
    rum.programs.helix = {
      enable = true;
      settings = {
        theme = "catppuccin_mocha";
        editor = {
          line-number = "relative";
          cursorline = true;
          color-modes = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides = {
            render = true;
          };
          file-picker.hidden = false; # Show hidden files
          continue-comments = false;
          bufferline = "multiple";
          popup-border = "all";
          lsp = {
            display-inlay-hints = true;
          };
          #whitespace.render = "all"; # Show whitespace
          soft-wrap = {
            enable = true;
          };
          end-of-line-diagnostics = "info";
          # inline-diagnostics = {
          #   cursor-line = "hint";
          #   other-lines = "error";
          # };
        };
      };
    };
  };
}
