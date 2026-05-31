{
  pkgs,
  inputs,
  config,
  ...
}:
let
  info = import ../info.nix;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "/home/" + info.login + "/.config/sops/age/keys.txt";
    };

    secrets = {
      "${info.login}/private_keys/u2f" = {
        owner = config.users.users.${info.login}.name;
        path = "/home/${info.login}/.config/nitrokey/u2f_keys";
      };
    };
  };

}
