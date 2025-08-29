{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
      home.username = "tony";
    home.homeDirectory = "/home/tony";
    home.stateVersion = "25.05";

    programs.git.enable = true;
    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo i use nixos btw";
        };
    };

    home.packages = with pkgs; [
        xwallpaper
        neovim
        nodejs_24
        ripgrep
        gcc
        cargo
        lua-language-server
    ];

    xdg.configFile."qtile" = {
        source = create_symlink "${dotfiles}/qtile";
        recursive = true;
    };
    xdg.configFile."nvim" = {
        source = create_symlink "${dotfiles}/nvim";
        recursive = true;
    };
    home.file.".walls".source = create_symlink ./walls;
}

