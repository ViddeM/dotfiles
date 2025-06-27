[font]
{% if hostname == "defcon-7" || hostname == "archdesk" || hostname == "CND207067Z" %}
size = 12.0
{% else %}
size = 24.0
{% end %}
   
[font.normal]
family = "MesloLGS Nerd Font Mono"
style = "Regular"
   
[[keyboard.bindings]]
action = "SpawnNewInstance"
key = "N"
mods = "Control|Shift"

[scrolling]
history = 10000
