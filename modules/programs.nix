{ pkgs, ... }:
{
  programs.light.enable = true;
  programs.light.brightnessKeys.enable = true;
  programs.light.brightnessKeys.step = 10;

  programs.hyprland = {
	  enable = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;
  programs.i3lock.enable = true;

  programs.kdeconnect.enable = true;
}
