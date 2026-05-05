{ pkgs, lib, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common = {
        default = [
          "kde"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "kde";
        "org.freedesktop.impl.portal.Screenshot" = "kde";
      };
    };
  };

  users.groups.video = { };
}
