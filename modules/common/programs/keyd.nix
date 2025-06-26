{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"]; # Any keyboard

      # For some reason, when using non-QWERTY keyboard layouts,
      # keyd still accepts keys from their QWERTY position.
      # e.g. to set `capslock-n = left`, one must set `capslock-j = left`
      settings = {
        main = {
          capslock = "overload(capslock, esc)";
        };
        "capslock:C" = {
          j = "left";
          k = "down";
          l = "right";
          i = "up";
        };
        "capslock+shift" = {
          j = "C-left";
          k = "C-down";
          l = "C-right";
          i = "C-up";
        };
      };
    };
  };
}
