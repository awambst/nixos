{ pkgs, ... }:
{
  services.connman = {
    enable = true;
    wifi.backend = "iwd"; # Support WiFi
    extraConfig = ''
      [General]
      PreferredTechnologies = ethernet,wifi
      SingleConnectedTechnology = false
    '';
  };
  services.udev.packages = [ pkgs.light ];

  services.actkbd = {
    enable = true;
    bindings = [
      {
        keys = [ 224 ];
        events = [ "key" ];
        # Use minimum brightness 0.05 so the display won't go totally black.
        command = "/run/current-system/sw/bin/light -N 0.01 && /run/current-system/sw/bin/light -U 5";
      }
      {
        keys = [ 225 ];
        events = [ "key" ];
        command = "/run/current-system/sw/bin/light -A 5";
      }
    ];
  };

  services.blueman.enable = true;

  services.pulseaudio.enable = false;
  services.pulseaudio.support32Bit = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa.support32Bit = true;
  };

  #USBs
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
