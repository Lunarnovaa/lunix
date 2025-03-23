{inputs, ...}: {
  perSystem = {
    inputs',
    system,
    pkgs,
    ...
  }: let
    astalPackages = with inputs'.ags.packages; [
      hyprland
      wireplumber
      network
      bluetooth
      battery
      apps
    ];
    nixPackages = [
      pkgs.pwvucontrol
      pkgs.blueberry
    ];
    extraPackages = astalPackages ++ nixPackages;
  in {
    # ags derivation for typescript
    packages.lags = inputs.ags.lib.bundle {
      src = ../../modules/desktop/hyprland/astal/src;
      inherit pkgs extraPackages;
      name = "lags";
      entry = "app.ts";
      gtk4 = true;
    };
    devShells.${system}.lags = pkgs.mkShell {
      buildInputs = [
        (inputs'.ags.packages.default.override {
          inherit extraPackages;
        })
      ];
    };
  };
}
