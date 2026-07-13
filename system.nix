let
  # We use these functions in this file
  inherit (builtins) filter;
  inherit (inputs.nixpkgs) lib;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  inherit (lib.trivial) pipe;

  # Grabbing inputs from tack, letting us use inputs the same way as with flakes
  inputs = import ./.tack;

  # Func for recursively importing modules
  listNixRecursive = dir:
    pipe dir [
      listFilesRecursive
      (filter (n: hasSuffix ".nix" n))
    ];

  # Func to generalize some code for configuration and importing
  mkHost = hostName:
    import "${inputs.nixpkgs}/nixos" {
      specialArgs = {inherit lib inputs;};
      configuration = {
        networking.hostName = hostName;
        imports =
          (listNixRecursive ./modules)
          ++ (listNixRecursive ./hosts/${hostName});
      };
    };
in
  /*
  Provide an attrset of host configurations.
  We always use nh to build, nixos-rebuild might require other settings.
  This requires us to not only tell nh to look in this file, but to provide
  it an attribute path to the relevant host. nh doesn't automatically check
  based on hostname, but we can basically replicate --hostname with -f.
  This gives us a command like:
    `nh os switch -f system.nix ${hostName}`
  Which conveniently we can very easily set with environmental variables.
  If we set $NH_FILE but not $NH_FLAKE, nh automatically looks here.
  We can then also set $NH_ATTRP to our desired hostname to build the
  correct hostname.
  */
  {
    polaris = mkHost "polaris";
    procyon = mkHost "procyon";
  }
