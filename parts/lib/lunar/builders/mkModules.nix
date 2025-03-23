lib: let
  inherit (lib.modules) mkDefault;
  inherit (lib.lunar.importers) listNixRecursive;
  inherit (lib.lists) flatten singleton;
  inherit (builtins) map concatLists;

  top = ../../../../.;
  moduleDir = top + /modules;
  hostDir = top + /hosts;
in
  {
    hostName,
    system,
    desktop,
    profiles,
    specialImports,
  }: (
    flatten (
      concatLists [
        # singleton just makes a list with one element
        (singleton {
          # Declare the hostName c:
          networking.hostName = hostName;

          nixpkgs = {
            hostPlatform = mkDefault system;
          };
        })

        # Import desktop and profile config modules
        (map (n: (moduleDir + /desktop + /${n} + /module.nix)) desktop)
        (map (n: (moduleDir + /profiles + /${n} + /module.nix)) profiles)

        # Import desktop and profile options modules
        # In theory, this shouldn't cause problems, so long as each host
        # import the desktop/profiles that they want to make available & configure
        # I could restructure my config to simplify the function, but I want to make
        # it easier to revert.
        (map (n: (moduleDir + /options/desktop + /${n} + ".nix")) desktop)
        (map (n: (moduleDir + /options/profiles + /${n} + ".nix")) profiles)

        # All hosts import the common modules
        (listNixRecursive (moduleDir + /common))
        (listNixRecursive (moduleDir + /options/common))

        # Import host modules
        (listNixRecursive (hostDir + /${hostName}))

        # Additional modules for importation can be declared as well.
        # This is usually system specific stuff.
        specialImports
      ]
    )
  )
