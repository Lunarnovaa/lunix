{
  # Enables Colemak systemwide
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };
  # Enable colemak in the tty + boot console
  console.useXkbConfig = true;
}
