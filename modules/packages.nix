{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "parsec-bin"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];
  environment.systemPackages = with pkgs; [
    #vesktop
    arrpc # To be able to use discord acivity detection
    vesktop

    r2modman

    libreoffice-qt6-still

    cmst
    connman

    mako
    libnotify

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
  ];
}
