{...}: {
  security.pam.enableSudoTouchIdAuth = true;
  # macOS system settings
  system = {
    #    # Configure keyboard
    #    keyboard = {
    #      enableKeyMapping = true;
    #      remapCapsLockToControl = true;
    #    };
    #
    #    # Configure default applications
    defaults = {
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
      #      dock = {
      #        autohide = true;
      #        orientation = "bottom";
      #        showhidden = true;
      #        mru-spaces = false;
      #      };
      #

      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
        #        AppleShowAllExtensions = true;
        #        FXEnableExtensionChangeWarning = false;
        #        QuitMenuItem = true;
        #        _FXShowPosixPathInTitle = true;
      };
    };
  };
}
