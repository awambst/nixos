{ pkgs, ... }:
{
  programs.light.enable = true;
  programs.light.brightnessKeys.enable = true;
  programs.light.brightnessKeys.step = 10;

  programs.i3lock.enable = true;

  programs.kdeconnect.enable = true;
}
