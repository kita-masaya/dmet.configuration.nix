# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # https://github.com/NixOS/nixpkgs/issues/27788
  boot.kernel.sysctl = {
    "vm.max_map_count" = 262144;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    defaultGateway = "172.16.1.254";
    nameservers = [ "172.16.1.254" "8.8.8.8" ];
    interfaces = [
     { useDHCP = true; }
     { name = "eno1"; ipAddress = "172.16.1.250"; prefixLength = 24; }
     { name = "eno2"; ipAddress = "192.168.1.1"; prefixLength = 16; }
    ];
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall = {
      enable = true;
      trustedInterfaces = [ "eno2" ];
      allowPing = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "jp106";
    defaultLocale = "ja_JP.UTF-8";
  };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  time.timeZone = "Asia/Tokyo";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget vim docker docker_compose openssh samba unzip git gdrive
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };
  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.cron.enable = true;
  services.cron.systemCronJobs = [
      "0 3  * * *   tono    cd /home/tono/mssql && ./renew_mssql_Kikan.sh 2>&1"
      "0 20 * * *   tono    cd /home/tono/gdrive && ./backup_redash.sh 2>&1"
      "30 3  * * *   tono    cd /home/tono/gdrive && ./sync_gdrive.sh 2>&1"
    ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.tono = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    home = "/home/tono";
    extraGroups = [ "wheel" "disk" "cdrom" "networkmanager" "docker" ];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3BIKCWCJjIfQiA+/fNH+6Xddm+dMySVrVuePjtLZjv9T+X46P3oUAOgmbKjnPWfeLYIOviNLAketHE1te7u0dAjO4QRpfvA5cM4B/C8ItSwZy+wqpmf7gpkyj109/K+hWM991zcHEY09qNG0YVemJ6ZhAw/P9ns1fIQjKUkZ4Waehmrp0tcKu7qClDTM2sb+bzOi2GnXQUYMmnKwL/Mp4CiFRUf6nqAuVd/op1ofbvTZPih4hY0P1MNDsApXpya38m7pt6M7GisNaX3T3rXFsQwiDMLZ44kgrLjaA6x8mwBQzoWyXP+deL9jCVc7ah4OCU6ncLgSPe0yZcF8GuE8l tono@sh76en" ];
  };
  security.sudo.enable = true;
  users.extraGroups.tono.gid = 1000;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
