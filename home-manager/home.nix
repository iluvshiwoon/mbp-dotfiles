# This is your home-manager configuration file
# Use this to configure your home environment
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Import your other home-manager configurations
    ./scripts
    ./shell
    ./programs
    ./modules
    ./theme
    inputs.nix-colors.homeManagerModules.default
    inputs.prism.homeModules.prism
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.emacs-overlay.overlays.package
      inputs.emacs-overlay.overlays.emacs
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Set your username and home directory
  home = {
    username = "kershuenlee";
    homeDirectory = "/Users/kershuenlee"; # Note: macOS uses /Users/ not /home/
  };

  colorScheme = inputs.nix-colors.colorSchemes.kanagawa;
  home.packages = with pkgs; [
    # macOS compatible packages
    bemoji
    nix-prefetch
    nixfmt
    #nodejs_21
    cmake
    gnumake
    tree
    unzip
    ripgrep
    coreutils
    fd
    bitwise # cli tool for bit / hex manipulation
    eza # ls replacement
    entr # perform action when file change
    file # Show file information
    fzf # fuzzy finder
    lazygit
    #libreoffice
    #nitch # system fetch util
    nix-prefetch-github
    pipx # Install Python applications in isolated environments
    ripgrep # grep replacement
    todo # cli todo list
    toipe # typing test in the terminal
    yazi # terminal file manager
    #youtube-dl
    ffmpeg
    libnotify
    man-pages # extra man pages
    ncdu # disk space
    openssl
    qalculate-gtk # calculator
    unzip
    wget
    xdg-utils
    bc
    # Remove packages that don't work well on macOS or are redundant:
    # brightnessctl, cool-retro-term, smplayer, cmatrix, gparted, valgrind, etc.

    # Install nerd fonts
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
