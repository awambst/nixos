{ pkgs, lib, inputs, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "parsec-bin" # ;-;
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "obsidian" # ;-;
    ];
  environment.systemPackages = with pkgs; [
    #vesktop
    arrpc # To be able to use discord acivity detection
    vesktop

    r2modman

    libreoffice-qt6-still
    onlyoffice-bin_latest

    cmst
    connman

    # notifications
    mako
    libnotify

    # confirm dialog
    zenity

    alacritty

    rustc
    rustup
    gcc

    hyprshot
    hypridle

    wofi

    pavucontrol

    prismlauncher # Minecraft launcher

    light

    octaveFull

    geeqie # Image viewer

    strongswan
    openssl

    obsidian
    logseq
    kdePackages.kate
    kdePackages.konsole

    teams-for-linux

    fzf

    htop

    filezilla

    inkscape-with-extensions

    gimp3-with-plugins

    sl
    fortune
    cowsay 

    vlc

    audacity

    hexedit

    python314Full

    shotcut

    # 3d and 3d printing
    blender
    cura-appimage
    freecad-qt6

    playerctl
  ];
}
