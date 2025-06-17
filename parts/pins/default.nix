let
  pins = import ./npins;
in {
  perSystem._module.args = {inherit pins;};
  flake = {inherit pins;};
}
