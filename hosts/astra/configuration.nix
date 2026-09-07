# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/spotify.nix
      inputs.spicetify-nix.nixosModules.spicetify
    ];

  nix.settings.trusted-users = [ "root" "spectra" ];

# ssh server, hopefullyyyyyyyy new
  services.openssh = {
    enable = true;
    ports = [ 5123 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "spectra" ];
    };
  };

  #services.fail2ban.enable = true;

# Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Steam
  programs.steam = {
    enable = true;
#    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  # OBS setup

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
    obs-pipewire-audio-capture
    obs-vaapi # AMD Hardware Accel
    obs-vkcapture # vulkan/openGL game capture
    ];
  };

  # KDE Connect
  programs.kdeconnect.enable = true;

  # OpenRGB
  services.hardware.openrgb.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "astra"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  #proton vpn setting
  networking.firewall.checkReversePath = false;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.extraLocales = [ "all" ];

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enabling Hyprland
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  #services.printing.enable = false;
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spectra = {
    isNormalUser = true;
    description = "spectra";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     openrgb-with-all-plugins kitty
     # screen copy for android manip
     scrcpy
     # NAT-PMP client for portforwarding protonvpn
     networkmanager-openvpn
     wireguard-tools
     proton-vpn-cli
     proton-vpn
     libnatpmp
     # torrent client
     deluge
     # media player library and client
     mpv
     haruna 
     #DAW 
     reaper
     element-desktop
     #nmap qt frontend
     nmap
     #wayland vnc client
     wlvncc
     krita
     # it works !!!
     xivlauncher
     # r2mod manager, here for gtfo
     r2modman
     # rustdesk, some random remote desktop system using it to play hsr ig
     rustdesk
     # moonlight, streaming client
     moonlight-qt
     gimp
     unrar
     gmad
     p7zip
     # auto clicker
     xclicker
     # shows mouse refresh rate
     evhz
     # configuring aerox mouse
     rivalcfg
     # rust stuff
     rustc
     cargo
     binutils gcc gnumake openssl pkg-config
     # vintage story (game)
     vintagestory     
     # minecraft
     prismlauncher
     # mod manager 4 cyberpunk
     #nexusmods-app-unfree
     # calc
     gnome-calculator
     wireshark
     libreoffice
     inetutils
     bftpd
     dnslookup
     git github-desktop
     fish neovim vesktop
     kdePackages.kdenlive
     kdePackages.kweathercore
     kdePackages.partitionmanager
     devenv
     home-manager
     obsidian
     azahar
     heroic gogdl
     protonplus
     lutris
     crossmacro
     nix-ld
     filezilla
     # RSS Stuff
     nom
     rssguard
     radare2
  ];

  fonts.fontDir.enable = true;
  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ]; 
#     nixpkgs.config.permittedInsecurePackages = [
#     "dotnet-runtime-7.0.20"
#     "libsoup-2.74.3"
#
#];
 

  services.deluge = {
    enable = true;
    openFirewall = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # services.vsftpd = { 
  #  enable = true;
  #  localUsers = true;
  #  userlist = ["spectra"];
  #  writeEnable = true;
  # };
  
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 59543 5123 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
