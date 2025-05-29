{
  description = "The second assignment for SEP is called A4-popular is about writing to a less informed audience";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    font-awesome = {
      url = "github:FortAwesome/Font-Awesome";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
      typix,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let

        pkgs = import nixpkgs { inherit system; };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./.config/treefmt.nix;
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run (import ./.config/pre-commit.nix);

        typixLib = typix.lib.${system};
        src = ./src;

        commonArgs = {
          typstSource = "main.typ";
          virtualPaths = [ ];
          fontPaths = [
            "${pkgs.roboto}/share/fonts/truetype"
            "${pkgs.libertine}/share/fonts/truetype/public"
          ];
        };

        unstable_typstPackages = [
          {
            name = "charged-ieee";
            version = "0.1.3";
            hash = "sha256-tfGeuggtRY74VBS4csaYrRF3mIhI2p+68YkJXLVdRNU=";
          }
        ];

        build-drv = typixLib.buildTypstProject (commonArgs // { inherit src unstable_typstPackages; });
        build-script = typixLib.buildTypstProjectLocal (
          commonArgs // { inherit src unstable_typstPackages; }
        );
        watch-script = typixLib.watchTypstProject commonArgs;

      in
      rec {
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Run ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        apps = rec {
          default = watch;
          build = flake-utils.lib.mkApp { drv = build-script; };
          watch = flake-utils.lib.mkApp { drv = watch-script; };
        };

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Develop ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        devShells.default = typixLib.devShell {
          extraShellHook = pre-commit-check.shellHook;
          buildInputs =
            pre-commit-check.enabledPackages
            ++ (with pkgs; [
              act # Run / check GitHub Actions locally.
              git # Pull, commit, and push changes.
              zathura # for live reloading of the PDF as you write it.
              typst # compile the document
            ]);
        };

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Build ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        packages.default = build-drv;

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Flake Check ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        checks = packages // {
          formatting = treefmtEval.config.build.check self;
          inherit pre-commit-check;
        };

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Fmt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        formatter = treefmtEval.config.build.wrapper;

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
      }
    );
}
