{inputs, ...}: {
  imports = inputs.lunarsLib.importers.listNixRecursive ./.;
}
