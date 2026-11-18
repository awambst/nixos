{ pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common = {
        default = [ "kde" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "kde" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "kde" ];
      };
    };
  };

  users.groups.video = { };
}
