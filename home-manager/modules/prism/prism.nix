{config, pkgs, ...}: 
{
  prism = {
    enable = true;
    wallpapers = ./wallpapers;
    outPath = ".config/home-manager/wallpapers";
    # colorscheme = with config.colorScheme.colors; [
    #   "${base00}"
    #   "${base01}"
    #   "${base02}"
    #   "${base03}"
    #   "${base04}"
    #   "${base05}"
    #   "${base06}"
    #   "${base07}"
    #   "${base08}"
    #   "${base09}"
    #   "${base0A}"
    #   "${base0B}"
    #   "${base0C}"
    #   "${base0D}"
    #   "${base0E}"
    #   "${base0F}"
    # ];
    colorscheme = config.colorScheme;
  };
}
