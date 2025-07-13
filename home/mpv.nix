{ pkgs, ... }:
{
  xdg.configFile = {
    "mpv/mpv.conf".text = ''
      vo=gpu-next
      save-position-on-quit=yes
      keep-open=yes
      osd-bar=no
    '';
    "mpv" = {
      source = pkgs.fetchzip {
        url = "https://github.com/tomasklaen/uosc/releases/download/5.10.0/uosc.zip";
        hash = "sha256-iGpCajrXEIain2O03ZmonW75QGDs1V5zvkx8FolGT2A=";
        stripRoot = false;
      };
      recursive = true;
    };
    "mpv/script-opts/uosc.conf".source = pkgs.fetchurl {
      url = "https://github.com/tomasklaen/uosc/releases/download/5.10.0/uosc.conf";
      hash = "sha256-LXszGeg/S6A32CmdKOrkLv7nWACsSooT4D6/U3GakBM=";
    };
    "mpv/scripts/thumbfast.lua".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/po5/thumbfast/9deb0733c4e36938cf90e42ddfb7a19a8b2f4641/thumbfast.lua";
      hash = "sha256-gfZOPIGzZxf5MX3NrHe1Sb+ze1rMAA60WuI4mvdR9Eg=";
    };
    "mpv/script-opts/thumbfast.conf".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/po5/thumbfast/9deb0733c4e36938cf90e42ddfb7a19a8b2f4641/thumbfast.conf";
      hash = "sha256-tM/C2HEeNgZ7BpLpIV1RiOLw8zcX1drKG90PLVU2DdI=";
    };
  };

}
