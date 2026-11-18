{ pkgs, info, ... }:
{
  environment.systemPackages = [
    pkgs.strongswan
    pkgs.openssl
  ];

  services.strongswan-swanctl.enable = info.vpn-admin-banquise;

  services.strongswan-swanctl.swanctl = {
    authorities = {
      banquise1.file = "/etc/swanctl/x509ca/BanquiseRootCA.cacert.pem";
      banquise2.file = "/etc/swanctl/x509ca/BanquiseMachineIssuingCA.cacert.pem";
      banquise3.file = "/etc/swanctl/x509ca/BanquiseMachineSubCA.cacert.pem";
      banquise4.file = "/etc/swanctl/x509ca/BanquiseUserIssuingCA.cacert.pem";
      banquise5.file = "/etc/swanctl/x509ca/BanquiseUserSubCA.cacert.pem";
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
