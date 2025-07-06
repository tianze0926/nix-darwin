{
  pkgs,
  inputs,
  lib,
  opt,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nil
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = opt.user;
  system.defaults.NSGlobalDomain = {
    ApplePressAndHoldEnabled = false;
    AppleShowAllFiles = true;
    AppleShowAllExtensions = true;
  };
  security.sudo.extraConfig = ''
    # Allow sudo without password for the primary user.
    ${opt.user} ALL=(ALL) NOPASSWD: ALL
  '';
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true; # sudo with touch ID
    reattach = true; # sudo with touch ID in tmux
  };

  homebrew = lib.mkMerge [
    opt.brewExtra
    {
      enable = true;
      onActivation.cleanup = "zap";
      caskArgs.no_quarantine = true;
      brews = [
        "tmux"
        "lazygit"
        "autossh"
        "neovim"
      ];
      casks = [
        # utility
        "alt-tab"
        "jordanbaird-ice"
        "karabiner-elements"
        "maccy"
        "monitorcontrol"
        "mos"
        "snipaste"
        "stats"
        # cli
        "font-code-new-roman-nerd-font"
        "miniforge"
        "wezterm@nightly"
        # office
        "arc"
        "zen"
        "gimp"
        "inkscape"
        "neteasemusic"
        "obs"
        "tencent-meeting"
        "visual-studio-code"
        "wechatwork"
        "wpsoffice-cn"
        "zotero"
      ];
    }
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${opt.user}" = ../home;
    extraSpecialArgs = {
      inherit opt;
    };
    backupFileExtension = "bak";
  };
  users.users."${opt.user}" = {
    home = "/Users/${opt.user}";
  };

  nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
}
