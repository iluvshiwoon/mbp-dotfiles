{ pkgs, inputs, config, ... }: 
  {
  home.packages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      config = ./emacs.d/init.el;
      defaultInitFile = true;
      package = pkgs.emacs-git;
      alwaysEnsure = true;
      alwaysTangle = true;
    })
  ];
  home.file = {
    ".emacs.d/" = {
      source = ./emacs.d;
      recursive = true;
    };
  };
}
