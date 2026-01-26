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
        off
    }
}

// Home desktop main monitor
output "Samsung Electric Company U28E570 HTPJ801556" {
    mode "3840x2160"
    position x=0 y=0
}

// Home new main monitor
output "ASUSTek COMPUTER INC XG32UCWMG T7LMQS015616" {
    mode "3840x2160@240.016"
    position x=0 y=0
}

// Home secondary monitor
output "PNP(BNQ) BenQ GL2450 3CD00873019" {
    mode "1920x1080"
    position x=2560 y=0
}

{% if hostname == "CND207067Z" %}
output "eDP-1" {
    mode "3840x2160"
    scale 2
    transform "normal"
    position x=0 y=0
}

// CYGNI SCREENS:

// Cygni office ultra-wide
output "Philips Consumer Electronics Company PHL 346B1C 1322131231233" {
    mode "3440x1440"

    scale 1

    position x=1920 y=0
}

// Stordalen TV (Cygni office)
output "Philips Consumer Electronics Company 86BDL3550Q 0x01010101" {
    mode "1920x1080"
    position x=1920 y=0
}

// Random cygni screen
output "Samsung Electric Company C34H89x H4ZRC03874" {
    mode "3440x1440@59.973"
    position x=1920 y=0
}

// END CYGNI SCREENS

// VOLVO SCREENS:

// Volvo office meeting room ??
output "PNP(LNO) ThinkSmart 0x00000004" {
    mode "1920x1080"

    scale 1
    
    transform "normal"
    
    position x=1920 y=0
}

// Volvo office curved HP
output "HP Inc. HP P34hc CN4131JLX" {
    mode "3440x1440"

    scale 1
    
    transform "normal"

    position x=3840 y=0
}

// Volvo meeting room screen
output "PNP(LNO) ThinkSmart 0x00000004" {
    mode "1920x1080"
    scale 1
    position x=0 y=1080
}

// Volvo Office Double monitor
output "HP Inc. HP 724pu CN44121YB6" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123QGW" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office other double monitors
output "HP Inc. HP 724pu CN44121X33" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123QGK" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121Y9X" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123PCQ" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121YB1" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123PD8" {
    mode "1920x1200"
    position x=3840 y=0
}

// Double monitor ecom area
output "HP Inc. HP 724pu CN44121YCT" {
    mode "1920x1200"
    position x=1920 y=0
}
 
output "HP Inc. HP 724pn CN44123Q7Z" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121Y64" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123KXR" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121Y9X" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123PCQ" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121YB1" {
    mode "1920x1200@59.950"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123PD8" {
    mode "1920x1200@59.950"
    position x=3840 y=0
}

// VCRS Office 
output "HP Inc. HP 724pu CN44121X33" {
    mode "1920x1200"
    position x=3840 y=0
}
output "HP Inc. HP 724pn CN44123QGK" {
    mode "1920x1200"
    position x=5760 y=0
}

// VCRS Office.
output "HP Inc. HP 724pu CN44121YCW" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123M5X" {
    mode "1920x1200"
    position x=3840 y=0
}

// VCRS F4 mob room
output "HP Inc. HP P34hc G4 CNC4131K5X" {
    mode "3440x1440"
    position x=0 y=-1080
}
output "LG Electronics LG SIGNAGE 0x01010101" {
    // mode "3840x2160"
    mode "1920x1080"
    position x=0 y=-2540
}

// END VOLVO SCREENS

{% end %}

// Settings that influence how windows are positioned and sized.
// Find more information on the wiki:
// https://github.com/YaLTeR/niri/wiki/Configuration:-Layout
layout {
    background-color "transparent"
    // When to center a column when changing focus, options are:
    // - "never", default behavior, focusing an off-screen column will keep at the left
    //   or right edge of the screen.
    // - "always", the focused column will always be centered.
    // - "on-overflow", focusing a column will center it if it doesn't fit
    //   together with the previously focused column.
    center-focused-column "never"
    // You can customize the widths that "switch-preset-column-width" (Mod+R) toggles between.
    preset-column-widths {
        // Proportion sets the width as a fraction of the output width, taking gaps into account.
        // For example, you can perfectly fit four windows sized "proportion 0.25" on an output.
        // The default preset widths are 1/3, 1/2 and 2/3 of the output.
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
        // Fixed sets the width in logical pixels exactly.
        // fixed 1920
    }
    // You can also customize the heights that "switch-preset-window-height" (Mod+Shift+R) toggles between.
    // preset-window-heights { }
    // You can change the default width of the new windows.
    default-column-width { proportion 0.5; }
    // If you leave the brackets empty, the windows themselves will decide their initial width.
    // default-column-width {}
    // By default focus ring and border are rendered as a solid background rectangle
    // behind windows. That is, they will show up through semitransparent windows.
    // This is because windows using client-side decorations can have an arbitrary shape.
    //
    // If you don't like that, you should uncomment `prefer-no-csd` below.
    // Niri will draw focus ring and border *around* windows that agree to omit their
    // client-side decorations.
    //
    // Alternatively, you can override it with a window rule called
    // `draw-border-with-background`.
    border {
        off
        width 4
        active-color   "#707070"      // Neutral gray
        inactive-color "#d0d0d0"      // Light gray
        urgent-color   "#cc4444"      // Softer red
    }
    shadow {
        softness 30
        spread 5
        offset x=0 y=5
        color "#0007"
    }
    struts {
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

// Include dms files
include "dms/colors.kdl"
include "dms/layout.kdl"
include "dms/alttab.kdl"
include "dms/binds.kdl"
include "dms/outputs.kdl"
include "dms/cursor.kdl"
