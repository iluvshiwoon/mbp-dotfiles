{
  description = "Your nix-darwin configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    
    # Nixpkgs-unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix-darwin
    darwin.url = "github:lnl7/nix-darwin/nix-darwin-24.11";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Additional inputs you still need
    nix-colors.url = "github:misterio77/nix-colors";
    prism.url = "github:IogaMaster/prism";
    zen-profile = {
    url = "git+ssh://git@github.com/iluvshiwoon/zen-profile?ref=main";
  # This will use your SSH key for authentication
};
    
    # Plugins
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    plugin-betterTerm-nvim.url = "github:CRAG666/betterTerm.nvim";
    plugin-betterTerm-nvim.flake = false;
    plugin-header_42_vim.url = "github:42Paris/42header";
    plugin-header_42_vim.flake = false;
    plugin-norminette-vim.url = "github:alexandregv/norminette-vim";
    plugin-norminette-vim.flake = false;
    plugin-windex-nvim.url = "github:declancm/windex.nvim";
    plugin-windex-nvim.flake = false;
    
    # Theme-related inputs
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-profile, darwin, ... }@inputs:
    let
      inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      # Formatter for your nix files, available through 'nix fmt'
      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable home-manager modules you might want to export
      homeManagerModules = import ./modules/home-manager;
      # Reusable darwin modules
      darwinModules = import ./modules/darwin;

      # nix-darwin configuration entrypoint
      # Available through 'darwin-rebuild switch --flake .#your-hostname'
      darwinConfigurations = {
        # Replace with your MacBook hostname
        Kers-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # M4 chip uses aarch64 architecture
          specialArgs = { inherit inputs outputs; };
          modules = [
            # Our main darwin configuration file
            ./darwin/configuration.nix
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # Update with your macOS username
        "kershuenlee@Kers-MacBook-Pro" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Use aarch64-darwin for M4
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            # Our main home-manager configuration file
            ./home-manager/home.nix
          ];
        };
      };
    };
}
