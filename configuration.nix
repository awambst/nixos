# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  pkgsUnstable,
  ...
}:
let
  info = import ./info.nix;
in
{

  services.thermald.enable = true;

  #nix.settings = {
  #substituters = [ "https://hyprland.cachix.org" ];
  #trusted-substituters = [ "https://hyprland.cachix.org" ];
  #trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  #};
  #nix.settings.substituters = [ "https://cache.nixos.org/" ];

  imports = [
    ./modules/steam.nix
    ./hardware-configuration.nix
    (import ./modules/strongswan.nix { inherit info; })
    (import ./modules/wg.nix { inherit info; })
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  boot.kernelPackages = pkgsUnstable.linuxPackages_6_19;

  services.sunshine = {
    enable = false;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
      LANG = if info.lang == "fr" then "fr_FR.UTF-8" else "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_ALL = "";
    };
    extraLocales = "all";
  };
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    exportConfiguration = true;
    windowManager = {
      i3.enable = true;
      awesome.enable = true;
    };
  };

  programs = {
    hyprland.enable = true;
    sway.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager = {
    enable = false;
    #    package = pkgsUnstable.kdePackages.plasma-login-manager;
  };

  services.displayManager.sddm = {
    enable = true;
    #package = pkgsUnstable.kdePackages.sddm;
    extraPackages = with pkgsUnstable; [
      kdePackages.breeze-icons
      kdePackages.kirigami
      kdePackages.libplasma
      kdePackages.qtsvg
      kdePackages.qtmultimedia
    ];
    theme = "sddm-astronaut-theme";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${info.login}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "pipewire"
      "netdev"
      "networkmanager"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  programs = {
    thunderbird.enable = true;
    git.enable = true;
  };

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    vim
    openh264
    betterlockscreen
    i3blocks
    sddm-astronaut
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
