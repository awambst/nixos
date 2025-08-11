{ info }:
{ ... }:
{
networking.wireguard.enable = info.wg-admin-homelab;
  networking.wireguard.interfaces = {
    homelab = {
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820;
      privateKeyFile = "/home/${info.login}/wireguard-keys/private";
      peers = [
        {
          publicKey = "G8ZCyCvjjf5nG2c9ikyKlGwEJ3kDk+GoH8S8l62jH2g=";
          allowedIPs = [
            "10.100.0.0"
            "10.0.0.0/8"
          ];
          endpoint = "napo280.fr:51820";
        }
      ];
    };

  };
  }
