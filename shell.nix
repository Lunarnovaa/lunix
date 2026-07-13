{
  inputs ? import ./.tack,
  pkgs ? import inputs.nixpkgs {},
}:
pkgs.mkShellNoCC {
  name = "Lunix";

  DIRENV_LOG_FORMAT = "";

  packages = with pkgs; [
    git

    # We need this to build nicely
    nh

    # Pinning with tack
    tack

    # cli editing suite
    helix
    lazygit
    zellij

    # Just in case
    statix
    alejandra
  ];
}
