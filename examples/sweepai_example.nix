{ pkgs, ... }: 
let
  nixos-shell = import (pkgs.fetchFromGitHub {
    owner = "Mic92";
    repo = "nixos-shell";
    rev = "bf6d25eef89e79a5e31cae17248b336290e9bc2c";
    sha256 = "1zn3h6b6d7jixqjf20xbwk5025y9lla9hzs5qs5j2x1rilgvf5xk";
  });
in
nixos-shell.mkShell {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.openssh.enable = true;
  documentation.enable = false;
}