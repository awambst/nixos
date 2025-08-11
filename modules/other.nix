{ pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
        "org.freedesktop.impl.portal.Screenshot" = "hyprland";
      };
    };
  };

  networking.wireless.iwd = {
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

  networking.networkmanager.enable = false;

  users.groups.video = { };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
