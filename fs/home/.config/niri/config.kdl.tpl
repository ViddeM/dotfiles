// This config is in the KDL format: https://kdl.dev
// "/-" comments out the following node.
// Check the wiki for a full description of the configuration:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Overview

config-notification {
    disable-failed
}

// Input device configuration.
// Find the full list of options on the wiki:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Input
input {
    keyboard {
        xkb {
            layout "us,se"
            // You can set rules, model, layout, variant and options.
            // For more information, see xkeyboard-config(7).

            // For example:
            // layout "us,ru"
            // options "grp:win_space_toggle,compose:ralt,ctrl:nocaps"

            options "caps:swapescape"
        }

        // Enable numlock on startup, omitting this setting disables it.
        numlock
    }

    // Next sections include libinput settings.
    // Omitting settings disables them, or leaves them at their default values.
    touchpad {
        // off
        tap
        // dwt
        // dwtp
        natural-scroll
        // accel-speed 0.2
        // accel-profile "flat"
        // scroll-method "two-finger"
        // disabled-on-external-mouse
    }

    mouse {
        // off

        // natural-scroll

        {% if hostname == "archdesk" %}
        accel-profile "flat"
        {% else %}
        // accel-profile "flat"
        {% end %}

        accel-speed 0.0
        // scroll-method "no-scroll"
    }

    trackpoint {
        // off
        // natural-scroll
        // accel-speed 0.2
        // accel-profile "flat"
        // scroll-method "on-button-down"
        // scroll-button 273
        // middle-emulation
    }

    // Uncomment this to make the mouse warp to the center of newly focused windows.
    // warp-mouse-to-focus

    // Focus windows and outputs automatically when moving the mouse into them.
    // Setting max-scroll-amount="0%" makes it work only on windows already fully on screen.
    // focus-follows-mouse max-scroll-amount="0%"
}

gestures {
    hot-corners {
        top-left
        top-right
    }
}

// Uncomment this line to ask the clients to omit their client-side decorations if possible.
// If the client will specifically ask for CSD, the request will be honored.
// Additionally, clients will be informed that they are tiled, removing some client-side rounded corners.
// This option will also fix border/focus ring drawing behind some semitransparent windows.
// After enabling or disabling this, you need to restart the apps for this to take effect.
prefer-no-csd
screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

overview {
    workspace-shadow {
        off
    }
}

environment {
  XDG_CURRENT_DESKTOP "niri"
}

hotkey-overlay {
    skip-at-startup
}

layer-rule {
    match namespace="^quickshell$"
    place-within-backdrop true
}

animations {
    workspace-switch {
        spring damping-ratio=0.80 stiffness=523 epsilon=0.0001
    }
    window-open {
        duration-ms 150
        curve "ease-out-expo"
    }
    window-close {
        duration-ms 150
        curve "ease-out-quad"
    }
    horizontal-view-movement {
        spring damping-ratio=0.85 stiffness=423 epsilon=0.0001
    }
    window-movement {
        spring damping-ratio=0.75 stiffness=323 epsilon=0.0001
    }
    window-resize {
        spring damping-ratio=0.85 stiffness=423 epsilon=0.0001
    }
    config-notification-open-close {
        spring damping-ratio=0.65 stiffness=923 epsilon=0.001
    }
    screenshot-ui-open {
        duration-ms 200
        curve "ease-out-quad"
    }
    overview-open-close {
        spring damping-ratio=0.85 stiffness=800 epsilon=0.0001
    }
}

// Window rules let you adjust behavior for individual windows.
// Find more information on the wiki:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Window-Rules
// Work around WezTerm's initial configure bug
// by setting an empty default-column-width.
window-rule {
    // This regular expression is intentionally made as specific as possible,
    // since this is the default config, and we want no false positives.
    // You can get away with just app-id="wezterm" if you want.
    match app-id=r#"^org\.wezfurlong\.wezterm$"#
    default-column-width {}
}
window-rule {
    match app-id=r#"^org\.gnome\."#
    draw-border-with-background false
    geometry-corner-radius 12
    clip-to-geometry true
}
window-rule {
    match app-id=r#"^gnome-control-center$"#
    match app-id=r#"^pavucontrol$"#
    match app-id=r#"^nm-connection-editor$"#
    default-column-width { proportion 0.5; }
    open-floating false
}
window-rule {
    match app-id=r#"^gnome-calculator$"#
    match app-id=r#"^galculator$"#
    match app-id=r#"^blueman-manager$"#
    match app-id=r#"^org\.gnome\.Nautilus$"#
    match app-id=r#"^steam$"#
    match app-id=r#"^xdg-desktop-portal$"#
    open-floating true
}
window-rule {
    match app-id=r#"^org\.wezfurlong\.wezterm$"#
    match app-id="Alacritty"
    match app-id="zen"
    match app-id="com.mitchellh.ghostty"
    match app-id="kitty"
    draw-border-with-background false
}
window-rule {
    match app-id=r#"firefox$"# title="^Picture-in-Picture$"
    match app-id="zoom"
    open-floating true
}
window-rule {
    match app-id="Mullvad VPN"
    open-floating false
}
// Open dms windows as floating by default
window-rule {
    match app-id=r#"org.quickshell$"#
    open-floating true
}

debug {
    honor-xdg-activation-with-invalid-serial
    keep-laptop-panel-on-when-lid-is-closed
}

// Override to disable super+tab
recent-windows {
    binds {
        Alt+Tab         { next-window scope="output"; }
        Alt+Shift+Tab   { previous-window scope="output"; }
        Alt+grave       { next-window filter="app-id"; }
        Alt+Shift+grave { previous-window filter="app-id"; }
    }
}

include "custom/outputs.kdl"

// Include dms files
include "dms/colors.kdl"
include "dms/layout.kdl"
include "dms/alttab.kdl"
include "dms/binds.kdl"
include "dms/outputs.kdl"
include "dms/cursor.kdl"

// We put this after the dms include in order to override its settings.
layout {
    focus-ring {
        width 1
    }

    border {
        width 1
        inactive-color "#353535"
    }
    
    preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
    }
    default-column-width { proportion 0.5; }

    center-focused-column "never"
}

