{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "iluvshiwoon";
    userEmail = "sntcillian@gmail.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  home.packages = [ pkgs.gh ];
}
