# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    nodejs = prev.nodejs_22;
    nodejs-slim = prev.nodejs-slim_22;
    #vimPlugins = prev.vimPlugins // {
    #  betterTerm-nvim = prev.vimUtils.buildVimPlugin {
    #    name = "betterTerm.nvim";
    #    src = inputs.plugin-betterTerm-nvim;
    #  };
    #  header_42_vim = prev.vimUtils.buildVimPlugin {
    #    name = "42_header.vim";
    #    src = inputs.plugin-header_42_vim;
    #  };
    #  norminette-vim = prev.vimUtils.buildVimPlugin {
    #    name = "norminette-vim";
    #    src = inputs.plugin-norminette-vim;
    #  };
    #  windex-nvim = prev.vimUtils.buildVimPlugin {
    #    name = "windex-nvim";
    #    src = inputs.plugin-windex-nvim;
    #  };
    # };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
