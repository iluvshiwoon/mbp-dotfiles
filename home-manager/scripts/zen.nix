{ config, pkgs, inputs,  ... }:

let
  zen_dir = "$HOME/Library/Application Support/zen";
  
  # Script to deploy the zen profile
    synczenProfile = pkgs.writeShellScriptBin "sync-zen-profile" ''
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p "${zen_dir}"
    if [ -z "$(ls -A "${zen_dir}")" ]; then
      echo "zen config empty ! copying files..."
      # Copy the profile from the flake input to the zen directory
      cp -r "${inputs.zen-profile}"/* "${zen_dir}"
      chmod -R u+w "${zen_dir}"
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
