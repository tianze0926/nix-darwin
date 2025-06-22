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
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#KQYGV764WY
      darwinConfigurations."KQYGV764WY" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          opt = {
            user = "zhoutianze";
            git.username = "zhoutianze";
            git.email = "zhoutianze@xiaohongshu.com";
          };
        };
        modules = [
          ./system
          home-manager.darwinModules.home-manager
        ];
      };
    };
}
