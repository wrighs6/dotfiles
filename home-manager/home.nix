{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      inputs.prismlauncher.overlays.default
      inputs.zig.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "wrighs6";
    homeDirectory = "/home/wrighs6";
  };

  # Add stuff for your user as you see fit:
    programs.git = {
      enable = true;
      userName  = "wrighs6";
      userEmail = "wrighs6@rpi.edu";
      extraConfig = {
        core.editor = "hx";
        init.defaultBranch = "main";
      };
    };

  home.packages = with pkgs; [
    steam
    wine
    lutris
    dolphin-emu-beta
    strawberry
    calibre
    nicotine-plus
    prismlauncher
    zigpkgs.master
    python311
    pipenv
    nodejs
    gdb
    texlive.combined.scheme-full
    valgrind
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
