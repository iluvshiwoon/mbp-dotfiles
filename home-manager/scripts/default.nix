{pkgs, ...}: let
  # usage
  # wall-change = pkgs.writeShellScriptBin "wall-change" ''swaybg -m fill -i $1'';
in {
  imports = [
    ./zen.nix
  ];
  home.packages = with pkgs; [
    # wall-change
  ];
}
