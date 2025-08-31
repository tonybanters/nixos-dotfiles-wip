{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
    home = {
        username = "tony";
        homeDirectory = "/home/tony";
        stateVersion = "25.05";
        packages = with pkgs; [
            xwallpaper
            neovim
            nodejs_24
            ripgrep
            gcc
            cargo
            lua-language-server
            rofi
        ];
        file."walls".source = create_symlink ./walls;
    };
    programs = {
        git = {
            enable = true;
        };
        bash = {
            enable = true;
            shellAliases = {
                btw = "echo i use nixos btw";
                syu="sudo nixos-rebuild switch --flake ~/nixos-dotfiles/.#nixos-btw";
            };
        };
    };

    xdg.configFile."qtile" = {
        source = create_symlink "${dotfiles}/qtile";
        recursive = true;
    };
    xdg.configFile."nvim" = {
        source = create_symlink "${dotfiles}/nvim";
        recursive = true;
    };
    xdg.configFile."rofi" = {
        source = create_symlink "${dotfiles}/rofi";
        recursive = true;
    };

}

