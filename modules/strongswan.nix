{ info }:
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.strongswan
    pkgs.openssl
  ];

  services.strongswan-swanctl.enable = info.vpn-admin-banquise;

  services.strongswan-swanctl.swanctl = {
    authorities = {
      banquise1.file = "/home/${info.login}/.secrets/strongswan/cacerts/BanquiseRootCA.cacert.pem";
      banquise2.file = "/home/${info.login}/.secrets/strongswan/cacerts/BanquiseMachineIssuingCA.cacert.pem";
      banquise3.file = "/home/${info.login}/.secrets/strongswan/cacerts/BanquiseMachineSubCA.cacert.pem";
      banquise4.file = "/home/${info.login}/.secrets/strongswan/cacerts/BanquiseUserIssuingCA.cacert.pem";
      banquise5.file = "/home/${info.login}/.secrets/strongswan/cacerts/BanquiseUserSubCA.cacert.pem";
    };

    connections = {
      banquise = {
        children = {
          banquise = {
            remote_ts = [ "10.0.0.0/9" ];
          };
        };
        local = {
          banquise.auth = "pubkey";
          banquise.certs = [
            "/home/${info.login}/.secrets/strongswan/x509/${info.login}.pem"
          ];
          # cle privee, "~/.secrets/strongswan/private/login.pem"
          # a mettre dans /etc/swanctl/private/login.pem
        };
        remote = {
          banquise.auth = "pubkey";
          banquise.id = "proxy1.la-banquise.fr";
        };
        remote_addrs = [ "89.168.61.117" ];
        vips = [ "0.0.0.0" ];
      };
    };
  };
}
