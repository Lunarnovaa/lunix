{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (builtins) readFile;
  inherit (lib.lists) singleton;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  catppuccin-mocha-yazi = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "1a8c939e47131f2c4bd07a2daea7773c29e2a774";
    hash = "sha256-hjqmNxIr/KCN9k5ZT7O994BeWdp56NP7aS34+nZ/fQQ=";
  };

  toml = pkgs.formats.toml {};

  cfg = config.lunix.programs.yazi;
in {
  options = {
    lunix.programs.yazi = {
      enable = mkEnableOption "Yazi" // {default = true;};
    };
  };
  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      settings = {
        theme = readFile "${catppuccin-mocha-yazi}/themes/mocha/catppuccin-mocha-rosewater.toml";
        yazi = toml.generate "yazi.toml" {
          mgr = {
            ratio = [1 4 3];
            sort_by = "natural";
            sort_sensitve = false;
            sort_reverse = false;
            sort_dir_first = true;
            sort_translit = true;
            linemode = "none";
            show_hidden = true;
            show_symlink = true;
            scrolloff = 5;
            mouse_events = ["click" "scroll"];
            title_format = "Yazi: {cwd}";
          };
          preview = {
            wrap = "no";
            tab_size = 2;
            max_width = 600;
            max_height = 900;
            catche_dir = "";
            image_delay = 30;
            image_filering = "triangle";
            image_quality = 75;
            ueberzug_scale = 1;
            ueberzug_offset = [0 0 0 0];
          };
          opener = {
            edit = singleton {
              run = "\${EDITOR:-vi} '$@'";
              desc = "$EDITOR";
              block = true;
              for = "unix";
            };
            open = singleton {
              run = "xdg-open '$1'";
              desc = "Open";
              for = "linux";
            };
            reveal = singleton {
              run = "xdg-open '$(dirname '$1')'";
              desc = "Reveal";
              for = "linux";
            };
            extract = singleton {
              run = "ya pub extract --list '$@'";
              desc = "Extract here";
              for = "unix";
            };
            play = singleton {
              run = "mpv --force-window '$@'";
              orphan = true;
              for = "unix";
            };
          };
          open = {
            rules = [
              {
                name = "*/";
                use = ["edit" "open" "reveal"];
              }
              {
                mime = "text/";
                use = ["edit" "reveal"];
              }
              {
                mime = "image/*";
                use = ["open" "reveal"];
              }
              {
                mime = "{audio,video}/*";
                use = ["play" "reveal"];
              }
              {
                mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
                use = ["extract" "reveal"];
              }
              {
                mime = "application/{json,ndjson}";
                use = ["edit" "reveal"];
              }
              {
                mime = "*/javascript";
                use = ["edit" "reveal"];
              }
              {
                name = "*";
                use = ["open" "reveal"];
              }
            ];
          };
          tasks = {
            micro_workers = 10;
            macro_workers = 10;
            bizarre_retry = 3;
            image_alloc = 536870912; # 512MB
            image_bound = [5000 5000];
            suppress_preload = false;
          };
          plugin = {
            fetchers = [
              # Mimetype
              {
                id = "mime";
                name = "*";
                run = "mime";
                prio = "high";
              }
            ];
            spotters = [
              {
                name = "*/";
                run = "folder";
              }
              # Code
              {
                mime = "text/*";
                run = "code";
              }
              {
                mime = "application/{mbox,javascript,wine-extension-ini}";
                run = "code";
              }
              # Image
              {
                mime = "image/{avif,hei?,jxl}";
                run = "magick";
              }
              {
                mime = "image/svg+xml";
                run = "svg";
              }
              {
                mime = "image/*";
                run = "image";
              }
              # Video
              {
                mime = "video/*";
                run = "video";
              }
              # Fallback
              {
                name = "*";
                run = "file";
              }
            ];
            preloaders = [
              # Image
              {
                mime = "image/{avif,hei?,jxl}";
                run = "magick";
              }
              {
                mime = "image/svg+xml";
                run = "svg";
              }
              {
                mime = "image/*";
                run = "image";
              }
              # Video
              {
                mime = "video/*";
                run = "video";
              }
              # PDF
              {
                mime = "application/pdf";
                run = "pdf";
              }
              # Font
              {
                mime = "font/*";
                run = "font";
              }
              {
                mime = "application/ms-opentype";
                run = "font";
              }
            ];
            previewers = [
              {
                name = "*/";
                run = "folder";
              }
              # Code
              {
                mime = "text/*";
                run = "code";
              }
              {
                mime = "application/{mbox,javascript,wine-extension-ini}";
                run = "code";
              }
              # JSON
              {
                mime = "application/{json,ndjson}";
                run = "json";
              }
              # Image
              {
                mime = "image/{avif,hei?,jxl}";
                run = "magick";
              }
              {
                mime = "image/svg+xml";
                run = "svg";
              }
              {
                mime = "image/*";
                run = "image";
              }
              # Video
              {
                mime = "video/*";
                run = "video";
              }
              # PDF
              {
                mime = "application/pdf";
                run = "pdf";
              }
              # Archive
              {
                mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
                run = "archive";
              }
              {
                mime = "application/{debian*-package,redhat-package-manager,rpm,android.package-archive}";
                run = "archive";
              }
              {
                name = "*.{AppImage,appimage}";
                run = "archive";
              }
              # Virtual Disk / Disk Image
              {
                mime = "application/{iso9660-image,qemu-disk,ms-wim,apple-diskimage}";
                run = "archive";
              }
              {
                mime = "application/virtualbox-{vhd,vhdx}";
                run = "archive";
              }
              {
                name = "*.{img,fat,ext,ext2,ext3,ext4,squashfs,ntfs,hfs,hfsx}";
                run = "archive";
              }
              # Font
              {
                mime = "font/*";
                run = "font";
              }
              {
                mime = "application/ms-opentype";
                run = "font";
              }
              # Empty file
              {
                mime = "inode/empty";
                run = "empty";
              }
              # Fallback
              {
                name = "*";
                run = "file";
              }
            ];
          };
        };
      };
    };
  };
}
