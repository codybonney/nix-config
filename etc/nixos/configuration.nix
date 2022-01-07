# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Denver";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  #networking.interfaces.enp45s0u2u4.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps,altwin:swap_alt_win";
    #displayManager.defaultSession = "none+bspwm";
    #windowManager.bspwm.enable = true; 
    desktopManager.xfce.thunarPlugins = [
      pkgs.xfce.thunar-archive-plugin
    ];
    synaptics.dev=''/dev/input/event11'';
    synaptics.enable = true; 
    synaptics.additionalOptions = ''
        Option "VertScrollDelta" "100"
        Option "HorizScrollDelta" "100"
        Option "CoastingSpeed" "1.000000"
        Option "MinSpeed" "1.100000"
        Option "MaxSpeed" "1.750000"
        Option "AccelFactor" "0.075000"
        Option "TrackstickSpeed" "1.000000"
        Option "PalmDetect" "on"
        Option "PressureMotionMinZ" "0"
        Option "PressureMotionMaxZ" "0"
        Option "PressureMotionMinFactor" "0.8"
        Option "PressureMotionMaxFactor" "0.8"
        Option "VertTwoFingerScroll" "on"
        Option "HorizTwoFingerScroll" "on"
        Option "RTCornerButton" "0"
        Option "RBCornerButton" "0"
        Option "LTCornerButton" "0"
        Option "LBCornerButton" "0"
        Option "TapButton1" "1"
        Option "TapButton2" "3"
        Option "TapButton3" "0"
        Option "MaxTapTime" "100"
        Option "MaxDoubleTapTime" "100"
        Option "ClickTime" "50"
        Option "PalmMinWidth" "4"
        Option "PalmMinZ" "50"

        Option "EmulateTwoFingerMinZ" "80"
        Option "EmulateTwoFingerMinW" "20"
        Option "FingerLow" "30"
        Option "FingerHigh" "50"
        Option "MaxTapTime" "125"
    '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cody = {
    isNormalUser = true;
    extraGroups = [
      "wheel" 
      "networkmanager"
      "video"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
     wget
     bspwm
     pnmixer
     maim
     evtest
     unzip
     jetbrains.idea-ultimate
     gnome.gucharmap
     nerdfonts
     parcellite
     slack
     sublime
     powertop
  ];

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
    EDITOR = "vim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nm-applet.enable = true;
  programs.light.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

