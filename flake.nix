{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    {
      darwinConfigurations =
        nixpkgs.lib.attrsets.mapAttrs
          (
            hostname: opt:
            nix-darwin.lib.darwinSystem {
              specialArgs = {
                inherit inputs opt;
              };
              modules = [
                ./system
                home-manager.darwinModules.home-manager
              ];
            }
          )
          {
            "Tianzes-MacBook-Air" = {
              user = "tianze";
              git.username = "tianze0926";
              git.email = "i@tianze.me";
              git.extraConfig = ''
                [http "https://github.com"]
                  proxy = socks5h://127.0.0.1:1080
              '';
              brewExtra = {
                brews = [
                  "yt-dlp"
                  "mpv"
                  "scrcpy"
                  "yazi"
                  "ollama"
                ];
                casks = [
                  "feishu"
                  "battery-toolkit"
                  "moonlight"
                  "prismlauncher"
                  "qbittorrent"
                  "seadrive"
                  "tailscale-app"
                  "wechat"
                  "google-chrome"
                  "quarkclouddrive"
                ];
                taps = [
                  "mhaeuser/mhaeuser"
                  "brewforge/chinese"
                ];
              };
            };
            "KQYGV764WY" = {
              user = "zhoutianze";
              git.username = "zhoutianze";
              git.email = "zhoutianze@xiaohongshu.com";
              brewExtra.casks = [
                "arc"
              ];
            };
          };
    };
}
