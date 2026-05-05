{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "obsidian" # ;-;
      "teamspeak6-client"
    ];
  environment.systemPackages = with pkgs; [
    teamspeak6-client
    #vesktop

    r2modman

    libreoffice-qt6-still
    onlyoffice-desktopeditors

    # notifications
    mako
    libnotify

    # confirm dialog
    zenity

    alacritty

    pavucontrol

    prismlauncher # Minecraft launcher

    octaveFull

    geeqie # Image viewer

    strongswan
    openssl

    obsidian
    logseq

    fzf

    htop

    filezilla

    gimp3-with-plugins

    sl
    fortune
    cowsay

    audacity

    shotcut

    # 3d and 3d printing
    #blender
    #cura-appimage
    #freecad-qt6

    playerctl

    logiops
  ];
}
