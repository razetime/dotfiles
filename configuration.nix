# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {}; # have unstable pkgs alongside stable.
  myKakoune =
  let
    config = pkgs.writeTextFile (rec {
      name = "kakrc.kak";
      destination = "/share/kak/autoload/${name}";
      text = ''
        set global ui_options ncurses_assistant=cat
      '';
    });
#    bqn = pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
#      pname = "bqn-kak";
#      version = "2023-01-22";
#      src = pkgs.fetchFromGitHub {
#        owner = "mlochbaum";
#        repo = "BQN";
#        rev = "049477ac67d6b91a0e24165541d023cf8dec05b9";
#        sha256 = "73e06eb89ebd8aea983fd6d8bfd1918735a0ec58e9d4617e2238210bcd56fdb9";
#      };
#      meta.homepage = "https://mlochbaum.github.io/BQN/editors/#kakoune";
#      preFixup = ''   
#        mv editors/kak/autoload/ .
#      '';
#    };
  in
  unstable.kakoune.override {
    plugins = with pkgs.kakounePlugins; [
      config
#      bqn
    ];
  };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # console options
  console.useXkbConfig = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # Setup static IP for NTHU DormNet
  networking.interfaces.eth0.ipv4.addresses = [ {
      address = "140.114.202.148";
      prefixLength = 24;
  } ];
  networking.defaultGateway = "140.114.202.254";
  networking.nameservers = [ "140.114.63.1" "140.114.64.1" ];

  nix.settings.experimental-features = "nix-command flakes";

  # Set your time zone.
  time.timeZone = "Asia/Taipei";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_TW.UTF-8";
    LC_IDENTIFICATION = "zh_TW.UTF-8";
    LC_MEASUREMENT = "zh_TW.UTF-8";
    LC_MONETARY = "zh_TW.UTF-8";
    LC_NAME = "zh_TW.UTF-8";
    LC_NUMERIC = "zh_TW.UTF-8";
    LC_PAPER = "zh_TW.UTF-8";
    LC_TELEPHONE = "zh_TW.UTF-8";
    LC_TIME = "zh_TW.UTF-8";
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-chewing
        fcitx5-gtk
    ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable modesetting driver for Intel
  services.xserver.videoDrivers = [ "modesetting" ];

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "cn,apl";
    xkbVariant = ",dyalog";
    xkbOptions = "grp:switch,compose:rwin";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.razetime = {
    isNormalUser = true;
    description = "Raghu Ranganathan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      jetbrains-mono
      irssi
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    unstable.cbqn-standalone-replxx
    ngn-k
    gnumake
    gcc9
    openssl
    libyaml
    zlib
    ruby
    cmakeMinimal
    (python311.withPackages(ps: with ps; [ pandas ]))
    myKakoune
    patchelf
    file
    unstable.typst
    rakudo
    unstable.scryer-prolog
    zlib
    unixtools.xxd
  ];

  environment.shellAliases = {
    jt = "~/code/truffleruby-ws/truffleruby/bin/jt";
  };
  # Doesn't work, permission problem
  # environment.interactiveShellInit = ''
  #   ln -s "${pkgs.bash}/bin/bash" /bin/bash
  #   ln -s /run/current-system/sw/bin/pwd /bin/pwd
  # '';
  environment.sessionVariables = {
     EDITOR = "kak";
     SYSTEM_RUBY = "${pkgs.ruby}/bin/ruby";
     LD_LIBRARY_PATH = "${pkgs.glibc}/lib:${pkgs.zlib}/lib";
     # JAVA_HOME   = "/home/razetime/.mx/jdks/labsjdk-ce-21-jvmci-23.1-b15";
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.activationScripts = {
    truffleruby = ''
      ln -sf "${pkgs.bash}/bin/bash" /bin/
      ln -sf "${pkgs.coreutils}/bin/pwd" /bin/
    '';
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
