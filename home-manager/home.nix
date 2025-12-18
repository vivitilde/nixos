{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "spectra";
  home.homeDirectory = "/home/spectra";
  home.stateVersion = "25.05"; 

  nixpkgs.config.allowUnfree = true;

  imports = [
#    ../modules/spotify.nix
    inputs.textfox.homeManagerModules.default
    ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  
  textfox = {
    enable = true;
    profile = "default";
  };
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    };

  programs.rmpc.enable = true;

  programs.btop.enable = true;

  programs.git = {
    enable = true;
    settings.user.name = "dark star";
    settings.user.email = "12040089+vivitilde@users.noreply.github.com";
  };
  programs.gitui.enable = true;

  programs.direnv = {
  enable = true;
  enableFishIntegration = true;
  };

  programs.obsidian.enable = true;
  programs.radio-active.enable = true;

  programs.clock-rs = {
  enable = true;

  settings = {
    general = {
      #color = "magenta";
      interval = 250;
      blink = true;
      bold = true;
    };

    position = {
      horizontal = "center";
      vertical = "center";
    };

    date = {
      fmt = "%A, %B %d, %Y";
      use_12h = true;
      #utc = true;
      hide_seconds = false;
      };
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      background_opacity = "0.5";
      background_blur = 5;
      shell = "fish";
    };
  };
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.neovim
    pkgs.legcord
    pkgs.fish
    pkgs.nvitop
    pkgs.mpv pkgs.haruna
    pkgs.scrcpy

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/spectra/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
