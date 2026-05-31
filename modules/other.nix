{ pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      #      pkgs.xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      KDE = {
        default = [ "kde" ];
        "org.freedesktop.impl.portal.ScreenCast" = "kde";
        "org.freedesktop.impl.portal.Screenshot" = "kde";
      };
    };
  };

  users.groups.video = { };
}
