{ info, pkgs, ... }:
{
  networking = {
    hostName = "${info.hostname}"; # Define your hostname.
    extraHosts = ''
      192.168.1.1 meteor.arcadyan.com
      127.0.0.1 paradise-s1.battleye.com
      127.0.0.1 test-s1.battleye.com
      127.0.0.1 paradiseenhanced-s1.battleye.com
    '';

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
    enable = false;
    #resolveLocalQueries = false;
    settings = {
      conf-file = "/etc/nixos/assets/domains.txt";
      bind-interfaces = false;
      server = [ "9.9.9.9" ];
      strict-order = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    traceroute
    networkmanagerapplet
    dig
  ];

}
