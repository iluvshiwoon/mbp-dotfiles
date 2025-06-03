# This is your home-manager configuration file
# Use this to configure your home environment
{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Import your other home-manager configurations
    ./scripts
    ./programs
    ./modules
    ./theme
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

  home.packages = with pkgs; [
    tree
    coreutils
    fzf # fuzzy finder
    ripgrep # grep replacement
    man-pages # extra man pages

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
