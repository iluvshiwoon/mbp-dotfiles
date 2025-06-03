{
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf"];
    };
    initExtraFirst = ''
      export PATH=~/.config/emacs/bin:$PATH
      DISABLE_MAGIC_FUNCTIONS=true
      export "MICRO_TRUECOLOR=1"
      eval "$(zoxide init --cmd cd zsh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    initExtra = ''
      flakify () {
        if [ -z "$1" ]; then
          echo "Error: Template name required"
          echo "Usage: nix-init-template <template-name>"
          return 1
        fi

        nix flake init --refresh -t "github:iluvshiwoon/dev-env#$1"
        direnv allow
        echo -e ".direnv\n.envrc" >> ./.gitignore
      }
    '';

    shellAliases = {
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
