{ config, pkgs, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        # shell = "${pkgs.nushell}/bin/nu";
        font = "FiraCode Nerd Font Mono:size=11";
      };
      colors = { alpha = 0.8; };
    };
  };
}
