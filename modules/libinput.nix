{ ... }:
{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true; # tap-to-click
      naturalScrolling = true; # optional, scrolling direction
      disableWhileTyping = true; # optional but recommended
      scrollMethod = "twofinger";
    };
  };
}
