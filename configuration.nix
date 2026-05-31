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

  boot.kernelPackages = pkgsUnstable.linuxPackages_7_0;

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
    };
  };

  fonts.packages = with pkgs; [
    font-awesome_7
    powerline-fonts
    powerline-symbols
    nerd-fonts._3270
    nerd-fonts.code-new-roman
    nerd-fonts.comic-shanns-mono
    nerd-fonts.cousine
    nerd-fonts.d2coding
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
    nerd-fonts.overpass
    nerd-fonts.roboto-mono
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
  ];

  programs = {
    sway.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager = {
    enable = true;
    package = pkgs.kdePackages.plasma-login-manager;
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
      "docker"
      "plugdev"
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
    vesktop
    i3status-rust
    swaylock-effects
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
