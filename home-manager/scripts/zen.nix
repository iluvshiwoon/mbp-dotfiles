{ config, pkgs, inputs,  ... }:

let
  zenProfileName = "l11nmepi.Default (release)"; # Replace with your profile name
  zenProfileDir = "${inputs.zen-profile}/${zenProfileName}";
  
  # Location where zen stores profiles on macOS
  zenProfilesDir = "$HOME/Library/Application Support/zen/Profiles";
  
  # Destination path for the profile
  destProfilePath = "${zenProfilesDir}/${zenProfileName}";
  
  # Script to deploy the zen profile
  synczenProfile = pkgs.writeShellScriptBin "sync-zen-profile" ''
    #!/usr/bin/env bash
    set -euo pipefail
    
    zen_DIR="${zenProfilesDir}"
    PROFILE_PATH="${destProfilePath}"
    
    echo "Checking for zen profile at $PROFILE_PATH"
    
    if [ ! -d "$PROFILE_PATH" ]; then
      echo "Profile does not exist. Deploying from flake input..."
      
      # Ensure the zen profiles directory exists
      mkdir -p "$zen_DIR"
      
      # Copy the profile from the flake input to the zen directory
      cp -r "${zenProfileDir}" "$PROFILE_PATH"
      
      echo "zen profile has been deployed successfully!"
    else
      echo "zen profile already exists. No action taken."
    fi
  '';

in {
  
  # Add the sync script to your packages
  home.packages = [ synczenProfile ];
  
 # Create an activation script to run the profile sync on each home-manager switch
  home.activation.synczenProfile = {
  after = ["writeBoundary"];
  before = [];
  data = ''
    $VERBOSE_ARG ${synczenProfile}/bin/sync-zen-profile
  '';
};
}
