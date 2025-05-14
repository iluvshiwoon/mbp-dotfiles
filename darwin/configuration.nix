# This is your nix-darwin configuration file
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    ./system-settings.nix
  ] ++ (builtins.attrValues outputs.darwinModules); # list: value of attr in set

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # Make nix commands consistent with the flake
  nix.nixPath = [{nixpkgs = "${inputs.nixpkgs}";}];

  # Nix configuration
  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    trusted-users = ["kershuenlee"];
    # Deduplicate and optimize nix store
  };
  nix.optimise.automatic = true;

  # Enable garbage collection to happen automatically
  nix.gc = {
    automatic = true;
    interval = {Day = 7;};
    options = "--delete-older-than 7d";
  };

  # Set your time zone
  #time.timeZone = "Europe/Paris";

  # Set your hostname
  networking.hostName = "Kers-MacBook-Pro";

  # Install system-wide packages
  environment.systemPackages = with pkgs; [
    git
    vim
  ];
  homebrew = {
    enable = true;

    global.autoUpdate = false;
    onActivation = {
      #      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.

      # Xcode = 497799835;
      # Wechat = 836500024;
      # NeteaseCloudMusic = 944848654;
      # QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      # TecentMetting = 1484048379;
      # QQMusic = 595615424;
      # Bitwarden = 1352778147;
    };

    taps = [
      #"homebrew/brew"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "mas"
      #"aria2" # download tool
      #"httpie" # http client
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      #"firefox"
      #"google-chrome"
      #"visual-studio-code"

      # IM & audio & remote desktop & meeting
      #"telegram"
      #"discord"
      "ghostty"
      "zen-browser"
      #"bitwarden"

      #"anki"
      #"iina" # video player
      #"raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      #"stats" # beautiful system monitor
      #"eudic" # 欧路词典

      # Development
      #"insomnia" # REST client
      #"wireshark" # network analyzer
    ];
  };

  # Configure shell - ZSH comes by default on macOS
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service
  services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enableCompletion = true;
  programs.zsh.enableBashCompletion = true;

  # Set up a default user
  users.users.kershuenlee = {
    name = "kershuenlee";
    home = "/Users/kershuenlee";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
