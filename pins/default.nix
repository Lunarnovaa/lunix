self: let
  inherit (builtins) fromJSON readFile;

  yaePin = name: (fromJSON (readFile "${self}/pins/yae.json"))."${name}";
in {
  nixpkgs = yaePin "nixpkgs";
  lunarsLib = yaePin "lunarsLib";
}
