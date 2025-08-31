{ config, lib, pkgs, ... }:

{
    imports =
        [ 
            ./hardware-configuration.nix
        ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos-btw";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Los_Angeles";

    services.xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 35;
        windowManager.qtile.enable = true;
        extraConfig = ''
      Section "Monitor"
        Identifier "Virtual-1"
        Option "PreferredMode" "1920x1080"
      EndSection
        '';
    };

    users.users.tony = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
            tree
        ];
    };

    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
        vim 
        wget
        alacritty
        git
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.05"; 

}

