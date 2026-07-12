{
  inputs ? import ./.tack,
  pkgs ? import inputs.nixpkgs {},
}:
pkgs.mkShellNoCC {
  name = "Lunix";

  DIRENV_LOG_FORMAT = "";

  packages = with pkgs; [
    git

    # Pinning with tack
    tack

    # Editing tools
    helix
    lazygit
    zellij
    statix
  ];
}
