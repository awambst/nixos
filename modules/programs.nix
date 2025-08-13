{ ... }:
{
  programs.thunar.enable = true;
  # Enable to be able to save preferences
  programs.xfconf.enable = true;

  programs.steam.enable = true;

  programs.light.enable = true;
  programs.light.brightnessKeys.enable = true;
  programs.light.brightnessKeys.step = 10;

  programs.hyprland = {
	  enable = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;

  programs.kdeconnect.enable = true;
}
