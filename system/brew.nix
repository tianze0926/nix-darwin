{ lib, opt, ... }:
{
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
        "baiduinput"
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
}
