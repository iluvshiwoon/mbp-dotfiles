{...}: {
  security.pam.enableSudoTouchIdAuth = true;

  myModules.screenshots = {
    enable = true;
    path = "/Users/kershuenlee/Pictures/Screenshots";
    usernameForPath = "kershuenlee";
  };

  system = {
    #    # Configure keyboard
    #    keyboard = {
    #      enableKeyMapping = true;
    #      remapCapsLockToControl = true;
    #    };
    #
    #    # Configure default applications
    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.5;
        static-only = true;
        tilesize = 50;
        show-recents = true;
        scroll-to-open = true;
        minimize-to-application = true;
        mineffect = "scale";
        launchanim = false;

        # corner actions
        wvous-bl-corner = 1; #disabled
        wvous-br-corner = 1; #disabled
        wvous-tl-corner = 1; #disabled
        wvous-tr-corner = 1; #disabled
      };

      screencapture = {
        disable-shadow = true;
      };
      #      NSGlobalDomain = {
      #        AppleKeyboardUIMode = 3;
      #        ApplePressAndHoldEnabled = false;
      #        InitialKeyRepeat = 20;
      #        KeyRepeat = 1;
      #        NSAutomaticCapitalizationEnabled = false;
      #        NSAutomaticDashSubstitutionEnabled = false;
      #        NSAutomaticPeriodSubstitutionEnabled = false;
      #        NSAutomaticQuoteSubstitutionEnabled = false;
      #        NSAutomaticSpellingCorrectionEnabled = false;
      #        _HIHideMenuBar = false;
      #      };
      #

      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        FXDefaultSearchScope = "SCcf";
        NewWindowTarget = "Home";
        QuitMenuItem = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
      };
    };
  };
}
