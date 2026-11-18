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
      "nvidia-settings"
      "nvidia-persistenced"
      "teamspeak6-client"
      "nvidia-kernel-modules"
    ];
  environment.systemPackages = with pkgs; [
    r2modman

    libreoffice-qt6-still
    onlyoffice-desktopeditors

    # notifications
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

    #logseq

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
