{ config, pkgs, ... }:

{
  # Basic user details
  home.username = "spent";
  home.homeDirectory = "/home/spent";

  # Home Manager release compatibility
  home.stateVersion = "23.11"; # Do not change unless you understand the implications.

  # Packages to install
  home.packages = with pkgs;[
    eza
    R
    rPackages.pwr
    rPackages.tidyverse
    rPackages.knitr
    rPackages.binom
    rPackages.scales

  ];

  # Git Configuration
  programs.git = {
    enable = true;
    userName = "KhalilAMARDJIA"; 
    userEmail = "khalil.amardjia@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };




  # WezTerm Configuration
  home.file = {
    ".config/wezterm/wezterm.lua" = {
        # TODO: xdg.configFile.".config/wezterm/wezterm.lua".source = ./dotfiles/wezterm.lua;
      text = ''
        local wezterm = require("wezterm")
        local config = {}

        config.window_close_confirmation = "NeverPrompt" -- not prompt when closing all tabs at once
        config.window_decorations = "RESIZE" -- remove title bar and keep resizing capability
        config.window_padding = {
          left = "2cell",
          right = "2cell",
          top = "3cell",
          bottom = "3cell",
        }
        config.font = wezterm.font_with_fallback({ "Iosevka Nerd Font", "JetBrainsMono NF", "MonoLisa" })
        config.font_size = 14
        config.window_background_opacity = 0.95

        function scheme_for_appearance(appearance)
          if appearance:find("Dark") then
            return "ayu"
          else
            return "ayu_light"
          end
        end

        wezterm.on("window-config-reloaded", function(window, pane)
          local overrides = window:get_config_overrides() or {}
          local appearance = window:get_appearance()
          local scheme = scheme_for_appearance(appearance)
          if overrides.color_scheme ~= scheme then
            overrides.color_scheme = scheme
            window:set_config_overrides(overrides)
          end
        end)

        -- Key bindings
        local act = wezterm.action

        config.keys = {
          { key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
          { key = "q", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
          { key = "LeftArrow", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
          { key = "RightArrow", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
          { key = "s", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
          { key = "S", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
          { key = "x", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
          { key = "LeftArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Next") },
          { key = "RightArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Prev") },
        }

        return config
      '';
    };
  };



  # Session variables (optional)
  home.sessionVariables = {
    # EDITOR = "emacs";
  };


  # SHELL config

  ## zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza";
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
        zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } 
        { name = "zsh-users/zsh-syntax-highlighting"; } 
        { name = "zdharma-continuum/fast-syntax-highlighting"; }
        { name = "marlonrichert/zsh-autocomplete"; }

      ];
    };
      oh-my-zsh = {
      enable = true;
      plugins = [ "git"];
      theme = "bira";
    };

    };


  # Let Home Manager manage itself
  programs.home-manager.enable = true;



}
