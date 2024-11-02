{
  pkgs,
  inputs,
  ...
}: let
  nixpkgs = import inputs.nixpkgs {system = pkgs.stdenv.system;};
  kpt = nixpkgs.callPackage .nix-modules/kpt/default.nix {};
in {
  packages = [
    nixpkgs.doctl
    kpt
  ];
  # See full reference at https://devenv.sh/reference/options/
}
