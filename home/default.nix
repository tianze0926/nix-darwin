{ opt, configSys, ... }:
let
  actualFile = file: path: {
    home.file."${file}" = {
      source = path;
      onChange = ''
        target="${file}"
        src="$(readlink "$target")"
        rm "$target"
        cp "$src" "$target"
      '';
    };
  };
in

{
  imports = [
    (actualFile ".config/karabiner/karabiner.json" ./karabiner.json)
    ./mpv.nix
  ] ++ configSys;

  targets.darwin.defaults.NSGlobalDomain.AppleLanguages = [
    "en-CN"
    "zh-Hans-CN"
  ];

  xdg.configFile."pip/pip.conf".text = ''
    [global]
    index-url = https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
  '';
  home.file.".condarc".text = ''
    custom_channels:
      conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  '';
  home.file.".gitconfig".text = ''
    [user]
      name = ${opt.git.username}
      email = ${opt.git.email}
    ${opt.git.extraConfig or ""}
  '';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
