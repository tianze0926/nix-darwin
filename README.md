This is a configuration of https://github.com/nix-darwin/nix-darwin

First time install:

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install # select `no` when prompted to install Determinate Nix
sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin
git clone git@github.com:tianze0926/nix-darwin.git .
sudo nix run 'nix-darwin/master#darwin-rebuild' -- switch
```

Reload after modifying the configuration:

```sh
sudo darwin-rebuild switch
```
