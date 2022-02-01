{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-cursor-theme-name = "Capitaine Cursors";
    };
  };

  home = {
    stateVersion = "21.11";
    username = "cody";
    homeDirectory = "/home/cody";
    packages = with pkgs; [
      arc-theme
      buku
      capitaine-cursors
      chromium
      dunst
      feh
      firefox
      fzf
      gimp
      gnome.gnome-calculator
      htop
      i3lock
      neofetch
      nodejs-17_x
      ripgrep
      rofi
      sxhkd
      taskwarrior
      polybar
      wmname
      xclip
      xfce.thunar
    ];
  };

  services = {
    network-manager-applet = {
      enable = true;
    };
    parcellite = {
      enable = true;
    };
    picom = {
      enable = true;
      vSync = true;
    };
    sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "alacritty";
        "super + b" = "bookmarks";
        "super + k" = "xkill";
        "super + space" = "rofi -show run";
        "super + shift + o" = "rofi -show ssh";
        "super + shift + Tab" = "rofi -show";
        "super + backslash" = "maim --hidecursor -s ~/images/screenshots/screenshot-$(date +%s).png";
        "super + Escape" = "pkill -USR1 -x sxhkd";
        "super + alt + Escape" = "bspc quit";
        "super + {_,shift + }q" = "bspc node -{c,k}";
        "super + m" = "bspc desktop -l next";
        "super + y" = "bspc query -N -n focused.automatic && bspc node -n last.!automatic || bspc node last.leaf -n focused";
        "super + g" = "bspc node -s biggest";
        "super + {t,shift + t,z,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
        "super + ctrl + {x,y,z}" = "bspc node -g {locked,sticky,private}";
        "super + r" = "bspc node -R 90";
        "super + {_,shift + }{a,s,w,d}" = "bspc node -{f,s} {west,south,north,east}";
        "super + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";
        "super + {_,shift + }c" = "bspc node -f {next,prev}";
        "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
        "super + shift + bracket{left,right}" = "bspc monitor -f {prev,next}";
        "super + {grave,Tab}" = "bspc {node,desktop} -f last";
        "super + {o,i}" = "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";
        "super + {1-9,0}" = "bspc desktop -f '^{1-9,10}'";
        "super + shift + {1-9,0}" = "bspc node -d '^{1-9,10}' -f";
        "super + ctrl + {a,s,w,d}" = "bspc node -p {west,south,north,east}";
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
        "super + ctrl + bracket{left,right}" = "bspwm_set_node_presel_ratio {decrease,increase} 0.25";
        "super + ctrl + shift + bracket{left,right}" = "bspwm_set_node_presel_ratio {decrease,increase}";
        "super + ctrl + space" = "bspc node -p cancel";
        "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
        "super + alt + {a,s,w,d}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        "super + alt + shift + {a,s,w,d}" = " bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        "super + {a,s,w,d}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
        "shift + XF86MonBrightnessUp" = "light -A 0.5";
        "shift + XF86MonBrightnessDown" = "light -U 0.5";
        "XF86MonBrightnessUp" = "light -A 5";
        "XF86MonBrightnessDown" = "light -U 5";
        "XF86AudioLowerVolume" = "amixer set Master 3%-";
        "XF86AudioRaiseVolume" = "amixer set Master 3%+";
        "XF86AudioMute" = "amixer set Master toogle";
      };
    };
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        colors = {
          primary = {
            background = "0x000000";
          };
        };
        font = {
          normal = {
            family = "Menlo for Powerline";
            style = "Regular";
          };
          bold = {
            family = "Menlo for Powerline";
            style = "Bold";
          };
          italic = {
            family = "Menlo for Powerline";
            style = "Italic";
          };
          bold_italic = {
            family = "Menlo for Powerline";
            style = "Bold Italic";
          };
          size = 7;
        };
        window = {
          padding = {
            x = 4;
            y = 4;
          };
        };
      };
    };
    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        cookie-autodelete
        i-dont-care-about-cookies
        ublock-origin
      ];
      profiles = {
        "cody" = {
          id = 0;
          settings = {
            "browser.fullscreen.autohide" = false;
            "browser.newtabpage.enabled" = false;
            "browser.search.suggest.enabled" = false;
            "browser.startup.homepage" = "about:blank";
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.urlbar.quicksuggest.scenario" = "offline";
            "browser.urlbar.suggest.bookmark" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "gfx.webrender.all" = true;
            "media.ffmpeg.vaapi.enabled" = true; # enable the use of VA-API with FFmpeg
            "media.ffvpx.enabled" = false; # disable the internal decoders for VP8/VP9
            "media.navigator.mediadatadecoder_vpx_enabled" = true; # enable hardware VA-API decoding for WebRTC
            "mousewheel.default.delta_multiplier_x" = 90;
            "mousewheel.default.delta_multiplier_y" = 90;
            "mousewheel.with_alt.action" = 0;
            "mousewheel.with_control.action" = 0;
            "mousewheel.with_meta.action" = 0;
            "network.trr.mode" = 5;
            "signon.rememberSignons" = false;
          };
        };
      };
    };
    git = {
      enable = true;
      userName = "Cody Bonney";
      userEmail = "me@codybonney.com";
      extraConfig = {
        core.editor = "vim";
      };
    };
    home-manager = {
      enable = true;
    };
    ssh = {
      matchBlocks = {
        "beta.codybonney.com" = {
          hostname = "beta.codybonney.com";
          user = "root";
        };
      };
    };
    vim = {
      enable = true;
      settings = {
        number = true;
      };
      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-airline
      ];
    };
  };

  xresources.properties = {
    "*color0" = "#555753";
    "*color1" = "#cc0000";
    "*color2" = "#4e9a06";
    "*color3" = "#c4a000";
    "*color4"= "#3465a4";
    "*color5" = "#75507b";
    "*color6" = "#06989a";
    "*color7" = "#d3d7cf";
    "*color8" = "#555753";
    "*color9" = "#ef2929";
    "*color10" = "#8ae234";
    "*color11" = "#fce94f";
    "*color12" = "#729fcf";
    "*color13" = "#ad7fa8";
    "*color14" = "#34e2e2";
    "*color15" = "#eeeeec";
  };

  xsession = {
    enable = true;
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "Capitaine Cursors";
      size = 24;
      defaultCursor = "left_ptr";
    };
    windowManager = {
      bspwm = {
        enable = true;
        monitors = {
          eDP-1 = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
        };
        settings = {
          border_width = 1;
          window_gap = 0;
          focused_border_color = "#e59400";
          active_border_color = "#2f343f";
          presel_feedback_color = "#84f09c";
          pointer_motion_interval = 10;
          pointer_action1 = "move";
          pointer_action2 = "resize_side";
          pointer_action3 = "resize_corner";
          initial_polarity = "second_child";
          split_ratio = 0.50;
          borderless_monocle = true;
          gapless_monocle = true;
          single_monocle = true;
        };
        rules = {
          "feh" = {
            state = "floating";
          };
        };
        startupPrograms = [
          "systemctl --user import-environment XAUTHORITY DISPLAY"
          "pnmixer"
          "polybar top"
          "feh --bg-fill ~/.background-image"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Scrolling Distance' 100, 100"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Coasting Speed' 1.000000 35.000000"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Move Speed' 1.100000 1.750000 0.075000 1.000000"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Palm Detection' 1"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Pressure Motion' 0 0"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Pressure Motion Factor' 0.8 0.8"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Two-Finger Scrolling' 1, 1"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Tap Action' 0, 0, 0, 0, 1, 3, 0"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Tap Durations' 100, 100, 50"
          "xinput set-prop 'SYNA8004:00 06CB:CD8B Touchpad' 'Synaptics Palm Dimensions' 4, 100"
          "xinput set-prop 'TPPS/2 Elan TrackPoint' 'Evdev Wheel Emulation' 1"
          "xinput set-prop 'TPPS/2 Elan TrackPoint' 'Evdev Wheel Emulation Button' 2"
          "xinput set-prop 'TPPS/2 Elan TrackPoint' 'Evdev Wheel Emulation Timeout' 200"
          "xinput set-prop 'TPPS/2 Elan TrackPoint' 'Evdev Wheel Emulation Axes' 6 7 4 5"
          "xinput set-prop 'TPPS/2 Elan TrackPoint' 'Device Accel Constant Deceleration' 1.800000"
          "xinput set-prop 'TPPS/2 Elan TrackPoint' 'Evdev Wheel Emulation Inertia' 100"
          "syndaemon -K -i 0.20 -R -d"
          "wmname LG3D" # fix IntelliJ IDEA
          "systemctl --user start network-manager-applet.service"
          "systemctl --user start parcellite.service"
          "systemctl --user start picom.service"
        ];
      };
    };
  };
}
