{ info, pkgs, ... }:
{
  networking = {
    hostName = "${info.hostname}"; # Define your hostname.
    nameservers = [ "127.0.0.1" ];
    extraHosts = "192.168.1.1 meteor.arcadyan.com";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd = {
      enable = true;
      settings = {
        IPv4 = {
          Dhcp = "yes";
          SendHostname = true;
        };
        IPv6 = {
          Enable = false;
        };
        Settings = {
          AutoConnect = true;
        };
        General = {
          EnableNetworkConfiguration = true;
        };
      };
    };

  };

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      conf-file = "/etc/nixos/assets/domains.txt";
      bind-interfaces = false;
      server = [ "9.9.9.9" ];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    traceroute
    networkmanagerapplet
  ];

}
