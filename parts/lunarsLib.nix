{lib, ...}: {
  perSystem = {pins, ...}: {config._module.args.lunarsLib = import pins.lunarsLib lib;};
}
