{ ... }:
{
  hm = [
    (
      { ... }:
      {
        home.file.".zshrc".source = ./.zshrc;
        xdg.configFile."zim/.zimrc".source = ./.zimrc;
      }
    )
  ];
  programs.zsh.enableCompletion = false;
}
