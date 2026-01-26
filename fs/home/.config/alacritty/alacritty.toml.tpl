[general]
import = [
    "~/.config/alacritty/dank-theme.toml"
]

[window]
decorations = "None"
padding = { x = 12, y = 12 }
opacity = 1.0

[cursor]
style = { shape = "Block", blinking = "On" }
blink-interval = 500
unfocused_hollow = true

[mouse]
hide_when_typing = true

[selection]
save_to_clipboard = false

[bell]
duration = 0

[keyboard]
bindings = [
  { key = "C",       mods = "Control|Shift", action = "Copy"  },
  { key = "V",       mods = "Control|Shift", action = "Paste" },
  { key = "N",       mods = "Control|Shift", action = "SpawnNewInstance" },
  { key = "Equals",  mods = "Control|Shift", action = "IncreaseFontSize" },
  { key = "Minus",   mods = "Control",       action = "DecreaseFontSize" },
  { key = "Key0",    mods = "Control",       action = "ResetFontSize"    },
  { key = "Enter",   mods = "Shift",         chars = "\n" },
]

[font]
{% if hostname == "defcon-7" || hostname == "archdesk" || hostname == "CND207067Z" %}
size = 12.0
{% else %}
size = 24.0
{% end %}
   
[font.normal]
family = "MesloLGS Nerd Font Mono"
style = "Regular"

[scrolling]
history = 10000


