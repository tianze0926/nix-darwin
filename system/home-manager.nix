{
  lib,
  config,
  opt,
  ...
}:
{
  options.hm =
    with lib;
    mkOption {
      default = [ ];
      type = types.listOf (types.functionTo types.attrs);
    };

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${opt.user}" = ../home;
    extraSpecialArgs = {
      inherit opt;
      configSys = config.hm;
    };
  };
}
