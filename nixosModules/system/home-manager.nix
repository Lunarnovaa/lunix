{inputs, ...}: {
  home-manager.sharedModules = [
    inputs.self.outputs.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home-manager.useGlobalPkgs = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "lunarnova" = import ./../../hosts/default/home.nix;
    };

    backupFileExtension = "backup2";
  };
}
