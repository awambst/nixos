{ pkgs, ... }:
{
  hardware.nitrokey.enable = true;

  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services.pcscd.enable = true;

  services.udev.extraRules = ''
    ACTION=="remove", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="20a0/42b2/*", RUN+="${pkgs.systemd}/bin/systemctl start nitrokey-lock.service"
  '';

  systemd.services.nitrokey-lock = {
    description = "Lock session on Nitrokey removal";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl --user -M 'arthur.wambst@' start nitrokey-lock.service";
    };
  };

  systemd.user.services.nitrokey-lock = {
    description = "Lock screen on Nitrokey removal";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "nitrokey-lock" ''
        if [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
          echo "sway!"
          /run/current-system/sw/bin/swaylock
        elif echo "$XDG_CURRENT_DESKTOP" | grep -qi "kde"; then
          echo "kde!"
          ${pkgs.systemd}/bin/loginctl lock-session
        else
          echo "else"
          ${pkgs.systemd}/bin/loginctl lock-session
        fi
      '';
    };
  };

  environment.systemPackages = [
    pkgs.pynitrokey
    pkgs.nitrokey-app2
    pkgs.opensc
    pkgs.pam_u2f
  ];

  security.pam = {
    sshAgentAuth.enable = true;
    u2f = {
      enable = true;
      control = "sufficient"; # key alone is enough, or use "required" for MFA
      settings = {
        authfile = "/home/arthur.wambst/.config/nitrokey/u2f_keys";
        cue = true; # prints "please touch your key"
        userpresence = 0;
        userverification = 0;
      };
    };

    # Apply to specific services:
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
      sudo.sshAgentAuth = true;
      polkit-1.u2fAuth = true;
      sddm.u2fAuth = true;
      plasmalogin.u2fAuth = true;
      pam.u2fAuth = true;
    };
  };
}
