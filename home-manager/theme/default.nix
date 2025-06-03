{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerdfonts
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode" "RobotoMono"];})
    pkgs.iosevka
    pkgs.twemoji-color-font
    pkgs.noto-fonts-emoji
  ];
}
