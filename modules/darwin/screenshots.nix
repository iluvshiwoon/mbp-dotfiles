{ lib, pkgs, config, ... }: # Standard nix-darwin module arguments

let
  cfg = config.myModules.screenshots;
in
{
  options.myModules.screenshots = {
    enable = lib.mkEnableOption "custom screenshot path management (no Home Manager)";

    path = lib.mkOption {
      type = lib.types.str;
      description = ''
        The absolute path where screenshots will be stored.
        Example: /Users/your-username/Pictures/Screenshots
        This option is mandatory if the module is enabled.
      '';
    };

    # Optional: Specify username if the path is in a user's home directory
    # to attempt to set correct ownership.
    usernameForPath = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        Optional: The macOS username whose home directory contains the path.
        If set, the activation script will attempt to 'chown' the created directory
        to this user. This is important if the path is like /Users/username/....
        The activation script runs as root.
      '';
      # example = "johndoe";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.path != null && cfg.path != "";
        message = "myModules.screenshots.path must be set when enabled.";
      }
      # If usernameForPath is provided, ensure it's not an empty string.
      {
        assertion = !(cfg.usernameForPath == ""); # !(false) is true, !(true) is false.
        message = "myModules.screenshots.usernameForPath cannot be an empty string if provided. Set to null or a valid username.";
      }
    ];

    # 1. Set the system-wide macOS default for screenshot location
    system.defaults.screencapture.location = cfg.path;

    # 2. Ensure the screenshot directory exists using a system activation script
    # This script runs as root during system activation (e.g., after `darwin-rebuild switch`).
    system.activationScripts.ensureScreenshotDirFromNixDarwin = {
      text = ''
        echo "Nix-Darwin (no HM): Ensuring screenshot directory ${cfg.path} exists..."
        # Create the directory. The -p flag creates parent directories if they don't exist
        # and doesn't error if the directory already exists.
        ${pkgs.coreutils}/bin/mkdir -p "${cfg.path}"
        echo "Nix-Darwin (no HM): Directory ${cfg.path} created/ensured."

        # If a username is provided and the path likely belongs to that user,
        # attempt to set ownership. This is important because mkdir above runs as root.
        ${lib.optionalString (cfg.usernameForPath != null) ''
          echo "Nix-Darwin (no HM): Attempting to set ownership of ${cfg.path} to ${cfg.usernameForPath}..."
          ${pkgs.coreutils}/bin/chown -R "${cfg.usernameForPath}" "${cfg.path}" || echo "Nix-Darwin (no HM): chown command failed, this might be okay if permissions are already correct or path is not user-specific."
          echo "Nix-Darwin (no HM): Ownership adjustment attempted for ${cfg.usernameForPath} on ${cfg.path}."
        ''}
      '';
      # Dependencies can be specified if needed, e.g., if this script
      # depends on other activation scripts.
      # deps = [];
    };
  };
}

