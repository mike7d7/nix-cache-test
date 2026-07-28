{
  description = "RStudio with custom R packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };

      RStudio-with-my-packages = pkgs.rstudioWrapper.override {
        packages = with pkgs.rPackages; [
          ggplot2
          dplyr
          fda
          tidyr
          zoo
        ];
      };
    in {
      packages.default = RStudio-with-my-packages;

      devShells.default = pkgs.mkShell {
        packages = [
          RStudio-with-my-packages
        ];
      };
    });
}
